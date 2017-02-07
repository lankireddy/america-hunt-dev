RSpec.describe PostsController, type: :controller do
  describe 'GET #show' do
    it 'assigns the requested post as @post' do
      post = Fabricate :post
      get :show, id: post.to_param
      expect(assigns(:post)).to eq(post)
    end
    it 'assigns the requested post\'s title to @page_title' do
      post = Fabricate :post
      get :show, id: post.to_param
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
      post = Fabricate :post
      get :index, {}
      expect(assigns(:posts)).to eq([post])
    end

    describe 'blog category id present' do
      let!(:selected_category) { Fabricate :blog_category }
      let!(:category_posts) { Fabricate.times 5, :post, blog_categories: [selected_category], featured_image: nil }

      it 'limits posts to blog category' do
        Fabricate.times 10, :post

        get :index, blog_category_id: selected_category.id

        expect(assigns(:posts).count).to eq 5
        expect(assigns(:posts).ids).to include(*category_posts.map(&:id))
      end

      describe 'foo' do
        12.times do
          it 'displays posts in their sort order' do
            selected_category.update(homepage_display: 1)
            category_posts.shuffle!
            category_posts.each_with_index do |cp, i|
              cp.reload
              cp.update(position: i + 1)
            end

            get :index, blog_category_id: selected_category.friendly_id
            posts = assigns(:posts)

            posts.each_with_index do |cp, i|
              cp.position.should eql(i + 1)
            end
          end
        end
      end

      it 'includes the category name in the page title' do
        get :index, blog_category_id: selected_category.id

        expect(assigns(:page_title)).to include(selected_category.name)
      end
    end
  end
end
