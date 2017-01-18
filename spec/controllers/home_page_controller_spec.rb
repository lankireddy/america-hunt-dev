describe HomePageController do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns widget blog categories' do
      widget_categories = Fabricate.times 2, :blog_category, homepage_display: 'widget'
      get :index
      expect(assigns(:widget_categories).ids).to match_array(widget_categories.map(&:id))
    end

    it 'assigns widget blog categories' do
      name_categories = Fabricate.times 2, :blog_category, homepage_display: 'name_only'

      get :index
      expect(assigns(:name_only_categories).ids).to match_array(name_categories.map(&:id))
    end

    it 'assigns published videos to @videos' do
      videos = Fabricate.times 2, :homepage_video, published: true
      unpublished_videos = Fabricate.times 2, :homepage_video
      get :index, {}
      expect(assigns(:videos)).to match_array(videos)
    end
  end

  describe 'Get #new_home' do
    it 'assigns the home page categories' do
      home_page_categories = {
        field_notes_from_game_wardens_category: BlogCategory.find_by(name: BlogCategory::FIELD_NOTES_FROM_GAME_WARDENS_TITLE),
        wildlife_category: BlogCategory.find_by(name: BlogCategory::WILDLIFE_NEWS_TITLE),
        hunting_org_category: BlogCategory.find_by(name: BlogCategory::HUNTING_ORG_TILE),
        primary_category: BlogCategory.find_by(name: BlogCategory::HUNTING_AND_SHOOTING_NEWS_TITLE)
      }
      get :new_home
      home_page_categories.each do |variable, category|
        expect(assigns(variable).name).to eq category.name
        expect(assigns(variable).id).to eq category.id
      end
    end
  end
end
