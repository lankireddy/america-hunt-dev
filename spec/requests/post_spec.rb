describe 'Post' do
  describe 'index' do
    it 'can be reached from the blog category route' do
      blog_category = Fabricate :blog_category
      visit blog_category_path(blog_category)
      expect(page).to have_selector('h1', text: blog_category.name)
    end
  end
end
