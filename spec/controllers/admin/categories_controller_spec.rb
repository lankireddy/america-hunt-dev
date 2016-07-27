require 'spec_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  login_admin
  render_views

  let(:valid_attributes) { (Fabricate.build :category).attributes }

  let(:invalid_attributes) { { name: ''} }

  describe 'GET #index' do
    it 'assigns all categories as @categories' do
      category = Category.create! valid_attributes
      get :index, {}
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested category as @category' do
      category = Category.create! valid_attributes
      get :show, {:id => category.to_param}
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'GET #new' do
    it 'assigns a new category as @category' do
      get :new, {}
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested category as @category' do
      category = Category.create! valid_attributes
      get :edit, {:id => category.to_param}
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Category' do
        expect {
          post :create, {:category => valid_attributes}
        }.to change(Category, :count).by(1)
      end

      it 'assigns a newly created category as @category' do
        post :create, {:category => valid_attributes}
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it 'redirects to the created category' do
        post :create, {:category => valid_attributes}
        expect(response).to redirect_to(admin_category_path(Category.last))
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved category as @category' do
        post :create, {:category => invalid_attributes}
        expect(assigns(:category)).to be_a_new(Category)
      end

      it 're-renders the "new" template' do
        post :create, {:category => invalid_attributes}
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { name: Faker::Commerce.department }
      }

      it 'updates the requested category' do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => new_attributes}
        category.reload
        expect(category.name).to eq(new_attributes[:name])
      end

      it 'assigns the requested category as @category' do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}
        expect(assigns(:category)).to eq(category)
      end

      it 'redirects to the category' do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}
        expect(response).to redirect_to(admin_category_path(category))
      end
    end

    context 'with invalid params' do
      it 'assigns the category as @category' do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => invalid_attributes}
        expect(assigns(:category)).to eq(category)
      end

      it 're-renders the "edit" template' do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => invalid_attributes}
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested category' do
      category = Category.create! valid_attributes
      expect {
        delete :destroy, {:id => category.to_param}
      }.to change(Category, :count).by(-1)
    end

    it 'redirects to the categories list' do
      category = Category.create! valid_attributes
      delete :destroy, {:id => category.to_param}
      expect(response).to redirect_to(admin_categories_path)
    end
  end
end
