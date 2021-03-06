describe HomePageController do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns widget blog categories' do
      Fabricate.times 2, :blog_category, homepage_display: 'widget'
      widget_categories = BlogCategory.widget
      get :index
      expect(assigns(:widget_categories).ids).to match_array(widget_categories.map(&:id))
    end

    it 'assigns widget blog categories' do
      name_categories = Fabricate.times 2, :blog_category, homepage_display: 'name_only'

      get :index
      expect(assigns(:name_only_categories).ids).to match_array(name_categories.map(&:id))
    end

    it 'assigns published videos to @videos' do
      published_videos = Fabricate.times 2, :homepage_video, published: true
      Fabricate.times 2, :homepage_video, published: false
      get :index, {}
      expect(assigns(:videos)).to match_array(published_videos)
    end
  end

  describe 'Get #new_home' do
    it 'assigns the primary categories' do
      get :new_home
      expect(assigns('primary_category')).to eq BlogCategory.widget.first
    end

    it 'assigns the secondary categories' do
      get :new_home
      expect(assigns('secondary_featured_categories')).to match_array(BlogCategory.secondary_featured.to_a)
    end
  end
end
