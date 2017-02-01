

RSpec.describe Admin::BlogCategoriesController, type: :controller do
  login_admin
  render_views

  let(:valid_attributes) { Fabricate.attributes_for :blog_category }

  let(:invalid_attributes) { { name: '' } }

  describe 'GET #index' do
    it 'assigns all blog_categories as @blog_categories' do
      BlogCategory.all.count.should_not eql(0)
      get :index, {}
      assigned =  assigns(:blog_categories)

      expect(assigned.map(&:id).sort).to eql(BlogCategory.all.map(&:id).sort)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested blog_category as @blog_category' do
      blog_category = BlogCategory.create! valid_attributes
      get :show, id: blog_category.to_param
      expect(assigns(:blog_category)).to eq(blog_category)
    end
  end

  describe 'GET #new' do
    it 'assigns a new blog_category as @blog_category' do
      get :new, {}
      expect(assigns(:blog_category)).to be_a_new(BlogCategory)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested blog_category as @blog_category' do
      blog_category = BlogCategory.create! valid_attributes
      get :edit, id: blog_category.to_param
      expect(assigns(:blog_category)).to eq(blog_category)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new BlogCategory' do
        expect do
          post :create, blog_category: valid_attributes
        end.to change(BlogCategory, :count).by 1
      end

      it 'assigns a newly created blog_category as @blog_category' do
        post :create, blog_category: valid_attributes
        expect(assigns(:blog_category)).to be_a BlogCategory
        expect(assigns(:blog_category)).to be_persisted
      end

      it 'redirects to the created blog_category' do
        post :create, blog_category: valid_attributes
        expect(response).to redirect_to(admin_blog_category_path(BlogCategory.last))
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved blog_category as @blog_category' do
        post :create, blog_category: invalid_attributes
        expect(assigns(:blog_category)).to be_a_new(BlogCategory)
      end

      it 're-renders the "new" template' do
        post :create, blog_category: invalid_attributes
        expect(response).to render_template 'new'
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: Faker::Commerce.department, homepage_display: 'name_only' }
      end

      it 'updates the requested blog_category' do
        blog_category = BlogCategory.create! valid_attributes
        put :update, id: blog_category.to_param, blog_category: new_attributes
        blog_category.reload
        expect(blog_category.name).to eq new_attributes[:name]
        expect(blog_category.homepage_display).to eq new_attributes[:homepage_display]
      end

      it 'assigns the requested blog_category as @blog_category' do
        blog_category = BlogCategory.create! valid_attributes
        put :update, id: blog_category.to_param, blog_category: valid_attributes
        expect(assigns(:blog_category)).to eq blog_category
      end

      it 'redirects to the blog_category' do
        blog_category = BlogCategory.create! valid_attributes
        put :update, id: blog_category.to_param, blog_category: valid_attributes
        expect(response).to redirect_to(admin_blog_category_path(blog_category))
      end
    end

    context 'with invalid params' do
      it 'assigns the blog_category as @blog_category' do
        blog_category = BlogCategory.create! valid_attributes
        put :update, id: blog_category.to_param, blog_category: invalid_attributes
        expect(assigns(:blog_category)).to eq blog_category
      end

      it 're-renders the "edit" template' do
        blog_category = BlogCategory.create! valid_attributes
        put :update, id: blog_category.to_param, blog_category: invalid_attributes
        expect(response).to render_template 'edit'
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested blog_category' do
      blog_category = BlogCategory.create! valid_attributes
      expect do
        delete :destroy, id: blog_category.to_param
      end.to change(BlogCategory, :count).by -1
    end

    it 'redirects to the blog_categories list' do
      blog_category = BlogCategory.create! valid_attributes
      delete :destroy, id: blog_category.to_param
      expect(response).to redirect_to(admin_blog_categories_path)
    end
  end
end
