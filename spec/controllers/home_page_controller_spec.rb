describe HomePageController do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns max of 7 content posts as @content_posts' do
      content_posts = Fabricate.times 10, :content_post
      get :index, {}
      expect(assigns(:content_posts).count).to eq(7)
    end

    it 'orders posts by weight then creation date' do
      post5 = Fabricate(:content_post, weight: nil)
      post2 = Fabricate(:content_post, weight: 4)
      post1 = Fabricate(:content_post, weight: 1)
      post3 = Fabricate(:content_post, weight: 7, created_at: 1.days.from_now)
      post4 = Fabricate(:content_post, weight: nil, created_at: 1.days.from_now)

      the_order = [post1.id, post2.id, post3.id, post4.id, post5.id]

      get :index, {}
      expect(assigns(:content_posts).map(&:id)).to eq(the_order)
    end

    it 'assigns all categories as @categories' do
      category = Fabricate :category
      get :index, {}
      expect(assigns(:categories)).to eq([category])
    end

    it 'assigns published videos to @videos' do
      videos = Fabricate.times 2, :homepage_video, published: true
      unpublished_videos = Fabricate.times 2, :homepage_video
      get :index, {}
      expect(assigns(:videos)).to match_array(videos)
    end
  end
end
