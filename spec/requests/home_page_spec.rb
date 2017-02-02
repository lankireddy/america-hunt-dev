describe 'HomePage' do
  context 'blog categories' do
    let!(:tile_categories) { BlogCategory.secondary_featured }
    let!(:under_widget_text_link_categories) { BlogCategory.under_widget_text_link }

    before do
      visit '/'
    end

    it 'displays links under widget' do
      under_widget_text_link_categories.each do |category|
        expect(page).to have_link(category.description, href: blog_category_path(category))
      end
    end

    it 'displays a link for each category' do
      tile_categories.each do |category|
        expect(page).to have_link(nil, href: blog_category_path(category))
      end
    end

    it 'displays a title for each category' do
      tile_categories.each do |category|
        expect(page).to have_selector('h2', text: category.name)
      end
    end

    it 'displays an image for each category' do
      tile_categories.each do |category|
        expect(page).to have_selector(".secondary-featured img[src*='#{ActionController::Base.helpers.image_path(category.image)}']")
      end
    end

    it 'displays a description for each category' do
      tile_categories.each do |category|
        expect(page).to have_selector('p', text: category.description.html_safe)
      end
    end
  end
end
