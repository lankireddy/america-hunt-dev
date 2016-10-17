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

  describe 'menu scope' do
    it 'returns categories that display on the homepage' do
      widget_categories = Fabricate.times 2, :blog_category, homepage_display: 'widget'
      name_only_categories = Fabricate.times 2, :blog_category, homepage_display: 'name_only'
      not_visible_categories = Fabricate.times 2, :blog_category, homepage_display: 'not_visible'
      menu_categories = BlogCategory.menu
      expect(menu_categories.ids).to include(*widget_categories.map(&:id))
      expect(menu_categories.ids).to include(*name_only_categories.map(&:id))
      expect(menu_categories.ids).to_not include(*not_visible_categories.map(&:id))
    end
  end
end
