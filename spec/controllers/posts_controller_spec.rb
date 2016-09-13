RSpec.describe PostsController, type: :controller do

  describe 'GET #show' do
    it 'assigns the requested post as @post' do
      post = Fabricate :post
      get :show, { id: post.to_param }
      expect(assigns(:post)).to eq(post)
    end
    it 'assigns the requested post\'s title to @page_title' do
      post = Fabricate :post
      get :show, { id: post.to_param }
      expect(assigns(:page_title)).to eq(post.title)
    end
  end

  describe 'GET #index' do
    it 'assigns all content posts as @content_posts' do
      content_post = Fabricate :content_post
      get :index, {}
      expect(assigns(:content_posts)).to eq([content_post])
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
  end

  describe 'GET #sales' do
    it 'assigns all link posts as @link_posts' do
      link_post = Fabricate :link_post
      get :sales, {}
      expect(assigns(:link_posts)).to include(link_post)
    end
  end
end
