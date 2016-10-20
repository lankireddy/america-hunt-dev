describe Post do

  it { is_expected.to have_many :blog_category_posts }
  it { is_expected.to have_many(:blog_categories).through(:blog_category_posts) }

  it { is_expected.to validate_presence_of(:title) }

  it 'should have valid fabricators' do
    expect(Fabricate.build(:post)).to be_valid
    expect(Fabricate.build(:post)).to be_valid
  end

  describe 'single post' do
    let!(:post) { Fabricate :post }

    describe '#title_short' do
      it 'returns shorter title' do
        expect(post.title_short.scan(/\w+/).size).to be <= Post::TITLE_SHORT_LENGTH
      end
    end

    describe '#to_s' do
      it 'returns the title of the post' do
        expect(post.to_s).to eq(post.title)
      end
    end
  end

  describe 'default_scope' do
    it 'returns posts in order of position when all have positions' do
      for i in 1..10
        Fabricate :post, position: i
      end
      expect(Post.all.ids).to eq Post.all.order(position: :asc).ids
      expect(Post.all.first.position).to eq 1
      expect(Post.all.last.position).to eq 10
    end

    it 'returns posts in order of recent to older when none have positions' do
      Fabricate.times 10, :post
      posts = Post.all
      expect(posts.ids).to eq Post.all.order(created_at: :desc).ids
      expect(posts.first.created_at).to eq posts.maximum(:created_at)
      expect(posts.last.created_at).to eq posts.minimum(:created_at)
    end

    it 'returns posts in the correct order' do
      post5 = Fabricate(:post, position: nil, title: 'no position, created now')
      post2 = Fabricate(:post, position: 4, title: 'position 4, created now')
      post1 = Fabricate(:post, position: 1, title: 'position 1, created now')
      post3 = Fabricate(:post, position: 7, created_at: 1.days.from_now, title: 'position 7, created tomorrow')
      post4 = Fabricate(:post, position: nil, created_at: 1.days.from_now, title: 'no position, created tomorrow')

      the_order = [post1.title, post2.title, post3.title, post4.title, post5.title]

      expect(Post.all.ids).to eq Post.all.order(position: :asc, created_at: :desc).ids

      expect(Post.all.map(&:title)).to eq(the_order)
    end
  end
end
