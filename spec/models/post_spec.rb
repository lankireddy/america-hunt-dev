describe Post do

  it { is_expected.to have_many :blog_category_posts }
  it { is_expected.to have_many(:blog_categories).through(:blog_category_posts) }

  it { is_expected.to validate_presence_of(:title) }

  it 'should have valid fabricators' do
    expect(Fabricate.build(:post)).to be_valid
    expect(Fabricate.build(:content_post)).to be_valid
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
    end
  end
end
