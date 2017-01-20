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
      get :new_home
      BlogCategory::STATIC_CATEGORIES.each do |name|
        expect(assigns("#{name}_category").name).to eq I18n.t(:name, scope: [:categories, name])
      end
    end
  end
end
