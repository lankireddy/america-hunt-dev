describe 'HomePage' do

  context 'secondary featured blog category tiles' do
    let!(:tile_categories) { [
        BlogCategory.wildlife_category,
        BlogCategory.field_notes_from_game_wardens_category
    ]
    }

    before do
      visit '/'
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
        expect(page).to have_selector('p', text: category.description)
      end
    end
  end
end
