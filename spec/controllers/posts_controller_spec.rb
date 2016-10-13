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
    it 'assigns homepage visible categories to @menu_categories' do
      Fabricate.times 2, :blog_category, homepage_display: 'widget'
      Fabricate.times 2, :blog_category, homepage_display: 'name_only'
      get :index, {}
      expect(assigns(:menu_categories)).to eq(BlogCategory.menu)
    end

    it 'assigns all posts as @posts' do
      content_post = Fabricate :content_post
      get :index, {}
      expect(assigns(:posts)).to eq([content_post])
    end

    it 'orders posts by position then creation date' do
      post5 = Fabricate(:content_post, position: nil)
      post2 = Fabricate(:content_post, position: 4)
      post1 = Fabricate(:content_post, position: 1)
      post3 = Fabricate(:content_post, position: 7, created_at: 1.days.from_now)
      post4 = Fabricate(:content_post, position: nil, created_at: 1.days.from_now)

      the_order = [post1.id, post2.id, post3.id, post4.id, post5.id]

      get :index, {}
      expect(assigns(:posts).map(&:id)).to eq(the_order)
    end

    describe 'blog category id present' do
      let!(:selected_category) { Fabricate :blog_category }
      let!(:category_posts) { Fabricate.times 5, :post, blog_categories: [selected_category] }

      it 'limits posts to blog category' do
        Fabricate.times 10, :post

        get :index, { blog_category_id: selected_category.id }

        expect(assigns(:posts).count).to eq 5
        expect(assigns(:posts).ids).to include(*category_posts.map(&:id))
      end

      it 'includes the category name in the page title' do
        get :index, { blog_category_id: selected_category.id }

        expect(assigns(:page_title)).to include(selected_category.name)
      end
    end
  end
end
