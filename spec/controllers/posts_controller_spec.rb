RSpec.describe PostsController, type: :controller do

  describe 'GET #show' do
    it 'assigns the requested post as @post' do
      post = Fabricate :post
      get :show, {:id => post.to_param}
      expect(assigns(:post)).to eq(post)
    end
    it 'assigns the requested post\'s title to @page_title' do
      post = Fabricate :post
      get :show, {:id => post.to_param}
      expect(assigns(:page_title)).to eq(post.title)
    end
  end

  describe 'GET #index' do
    it 'assigns all content posts as @content_posts' do
      content_post = Fabricate :content_post
      get :index, {}
      expect(assigns(:content_posts)).to eq([content_post])
    end
  end

  describe 'GET #sales' do
    it 'assigns all link posts as @link_posts' do
      link_post = Fabricate :link_post
      get :sales, {}
      expect(assigns(:link_posts)).to include(link_post)
    end
  end
end
