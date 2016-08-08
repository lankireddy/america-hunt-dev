describe HomePageController do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns all content posts as @content_posts' do
      content_post = Fabricate :content_post
      get :index, {}
      expect(assigns(:content_posts)).to eq([content_post])
    end
  end
end
