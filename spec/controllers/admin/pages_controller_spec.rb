

RSpec.describe Admin::PagesController, type: :controller do
  login_admin
  render_views

  let(:valid_attributes) { (Fabricate.build :page).attributes }

  let(:invalid_attributes) { { title: '' } }

  describe 'GET #index' do
    it 'assigns all pages as @pages' do
      page = Page.create! valid_attributes
      get :index, {}
      expect(assigns(:pages)).to include page
    end
  end

  describe 'GET #show' do
    it 'assigns the requested page as @page' do
      page = Page.create! valid_attributes
      get :show, { id: page.to_param }
      expect(assigns(:page)).to eq(page)
    end
  end

  describe 'GET #new' do
    it 'assigns a new page as @page' do
      get :new, {}
      expect(assigns(:page)).to be_a_new(Page)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested page as @page' do
      page = Page.create! valid_attributes
      get :edit, { id: page.to_param }
      expect(assigns(:page)).to eq(page)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Page' do
        expect {
          post :create, { page: valid_attributes }
        }.to change(Page, :count).by(1)
      end

      it 'assigns a newly created page as @page' do
        post :create, { page: valid_attributes }
        expect(assigns(:page)).to be_a(Page)
        expect(assigns(:page)).to be_persisted
      end

      it 'redirects to the created page' do
        post :create, { page: valid_attributes }
        expect(response).to redirect_to(admin_page_path(Page.last))
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved page as @page' do
        post :create, { page: invalid_attributes }
        expect(assigns(:page)).to be_a_new(Page)
      end

      it 're-renders the "new" template' do
        post :create, { page: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { title: Faker::Commerce.department }
      }

      it 'updates the requested page' do
        page = Page.create! valid_attributes
        put :update, { id: page.to_param, page: new_attributes}
        page.reload
        expect(page.title).to eq(new_attributes[:title])
      end

      it 'assigns the requested page as @page' do
        page = Page.create! valid_attributes
        put :update, { id: page.to_param, page: valid_attributes }
        expect(assigns(:page)).to eq(page)
      end

      it 'redirects to the page' do
        page = Page.create! valid_attributes
        put :update, { id: page.to_param, page: valid_attributes }
        expect(response).to redirect_to(admin_page_path(page))
      end
    end

    context 'with invalid params' do
      it 'assigns the page as @page' do
        page = Page.create! valid_attributes
        put :update, { id: page.to_param, page: invalid_attributes }
        expect(assigns(:page)).to eq(page)
      end

      it 're-renders the "edit" template' do
        page = Page.create! valid_attributes
        put :update, { id: page.to_param, page: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested page' do
      page = Page.create! valid_attributes
      expect {
        delete :destroy, { id: page.to_param }
      }.to change(Page, :count).by(-1)
    end

    it 'redirects to the pages list' do
      page = Page.create! valid_attributes
      delete :destroy, { id: page.to_param }
      expect(response).to redirect_to(admin_pages_path)
    end
  end
end
