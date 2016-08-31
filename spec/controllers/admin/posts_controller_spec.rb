

RSpec.describe Admin::PostsController, type: :controller do
  login_admin
  render_views

  let(:valid_attributes) { (Fabricate.build :post).attributes }

  let(:invalid_attributes) { { title: '' } }

  describe 'GET #index' do
    it 'assigns all posts as @posts' do
      post = Post.create! valid_attributes
      get :index, {}
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested post as @post' do
      post = Post.create! valid_attributes
      get :show, { id: post.to_param }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'GET #new' do
    it 'assigns a new post as @post' do
      get :new, {}
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested post as @post' do
      post = Post.create! valid_attributes
      get :edit, { id: post.to_param }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Post' do
        expect {
          post :create, {:post => valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it 'assigns a newly created post as @post' do
        post :create, {:post => valid_attributes }
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end

      it 'assigns categories based on ids' do
        blog_categories = Fabricate.times 2, :blog_category
        post :create, { post: valid_attributes.merge({ blog_category_ids: blog_categories.map(&:id) }) }
        post = assigns(:post)
        expect(post.blog_categories.count).to eq(2)
        expect(post.blog_category_ids).to eq(blog_categories.map(&:id))
      end

      it 'redirects to the created post' do
        post :create, {:post => valid_attributes }
        expect(response).to redirect_to(admin_post_path(Post.last))
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved post as @post' do
        post :create, {:post => invalid_attributes }
        expect(assigns(:post)).to be_a_new(Post)
      end

      it 're-renders the "new" template' do
        post :create, {:post => invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { title: Faker::Commerce.department }
      }

      it 'updates the requested post' do
        post = Post.create! valid_attributes
        put :update, { id: post.to_param, :post => new_attributes}
        post.reload
        expect(post.title).to eq(new_attributes[:title])
      end

      it 'assigns the requested post as @post' do
        post = Post.create! valid_attributes
        put :update, { id: post.to_param, :post => valid_attributes }
        expect(assigns(:post)).to eq(post)
      end

      it 'changes blog_category list to reflect ids' do
        post = Post.create! valid_attributes
        post.blog_categories << (Fabricate :blog_category)
        new_blog_categories = Fabricate.times 2, :blog_category
        put :update, { id: post.to_param, post: { blog_category_ids: new_blog_categories.map(&:id) }}
        post.reload
        expect(post.blog_categories).to eq(new_blog_categories)
      end

      it 'redirects to the post' do
        post = Post.create! valid_attributes
        put :update, { id: post.to_param, :post => valid_attributes }
        expect(response).to redirect_to(admin_post_path(post))
      end
    end

    context 'with invalid params' do
      it 'assigns the post as @post' do
        post = Post.create! valid_attributes
        put :update, { id: post.to_param, :post => invalid_attributes }
        expect(assigns(:post)).to eq(post)
      end

      it 're-renders the "edit" template' do
        post = Post.create! valid_attributes
        put :update, { id: post.to_param, :post => invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested post' do
      post = Post.create! valid_attributes
      expect {
        delete :destroy, { id: post.to_param }
      }.to change(Post, :count).by(-1)
    end

    it 'redirects to the posts list' do
      post = Post.create! valid_attributes
      delete :destroy, { id: post.to_param }
      expect(response).to redirect_to(admin_posts_path)
    end
  end
end
