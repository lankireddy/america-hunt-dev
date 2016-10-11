describe BlogCategory do
  let(:blog_category) { Fabricate :blog_category }

  it { is_expected.to have_many :blog_category_posts }
  it { is_expected.to have_many(:posts).through(:blog_category_posts) }

  it { is_expected.to validate_presence_of :name }

  it 'should have a valid fabricator' do
    expect(Fabricate.build(:blog_category)).to be_valid
  end

  describe '#to_s' do
    it 'returns the name of the category' do
      expect(blog_category.to_s).to eq(blog_category.name)
    end
  end
end
