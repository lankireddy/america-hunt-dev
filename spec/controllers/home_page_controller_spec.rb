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
    it 'assigns the then green line category' do
      thin_green_line = Fabricate.create :blog_category, name: 'The Thin Green Line'
      get :new_home
      expect(assigns(:field_notes_from_game_wardens_category).id).to eq thin_green_line.id
    end
  end
end
