describe 'HomePage' do

  context 'secondary featured blog category tiles' do
    let!(:tile_categories) { [
        Fabricate.create( :blog_category, name: BlogCategory.WILDLIFE_NEWS_TITLE ),
        Fabricate.create( :blog_category, name: BlogCategory.FIELD_NOTES_FROM_GAME_WARDENS_TITLE )
    ]
    }

    before do
      visit '/'
    end

    it 'displays a link for each category' do
      tile_categories.each do |category|
        expect(page).to have_selector(nil, href: blog_category_path(category))
      end
    end

    it 'displays a title for each category' do
      tile_categories.each do |category|
        expect(page).to have_selector('h2', text: category.name)
      end
    end
    it 'displays an image for each category' do
      tile_categories.each do |category|
        expect(page).to have_selector('.secondary-featured img')
      end
    end
  end
end
