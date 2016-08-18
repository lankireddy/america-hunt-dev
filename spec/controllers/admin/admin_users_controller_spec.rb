

RSpec.describe Admin::AdminUsersController, type: :controller do
  login_admin
  render_views

  let(:valid_attributes) { (Fabricate.build :admin_user).attributes.except(:id).merge({ password: 'testPassword'}) }
  let(:invalid_attributes) { { email: 'invalid_email.com' } }


  describe 'GET #index' do
    it 'assigns all AdminUsers as @AdminUsers' do
      admin_user = Fabricate :admin_user
      get :index, {}
      expect(assigns(:admin_users)).to include(*AdminUser.all)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested admin_user as @admin_user' do
      admin_user = Fabricate :admin_user
      get :show, {:id => admin_user.to_param}
      expect(assigns(:admin_user)).to eq(admin_user)
    end
  end

  describe 'GET #new' do
    it 'assigns a new admin_user as @admin_user' do
      get :new, {}
      expect(assigns(:admin_user)).to be_a_new(AdminUser)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested admin_user as @admin_user' do
      admin_user = Fabricate :admin_user
      get :edit, {:id => admin_user.to_param}
      expect(assigns(:admin_user)).to eq(admin_user)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new admin_user' do
        expect {
          post :create, {admin_user: valid_attributes}
        }.to change(AdminUser, :count).by(1)
      end

      it 'assigns a newly created admin_user as @admin_user' do
        post :create, {:admin_user => valid_attributes}
        expect(assigns(:admin_user)).to be_a(AdminUser)
        expect(assigns(:admin_user)).to be_persisted
      end

      it 'redirects to the created admin_user' do
        post :create, {:admin_user => valid_attributes}
        expect(response).to redirect_to(admin_admin_user_path(AdminUser.last))
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved admin_user as @admin_user' do
        post :create, {:admin_user => invalid_attributes}
        expect(assigns(:admin_user)).to be_a_new(AdminUser)
      end

      it 're-renders the "new" template' do
        post :create, {:admin_user => invalid_attributes}
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @admin_user = Fabricate :admin_user
    end
    context 'with valid params' do
      let(:new_attributes) {
        { email: 'fake_email@email.com' }
      }


      it 'updates the requested admin_user' do
        put :update, {:id => @admin_user.to_param, :admin_user => new_attributes}
        @admin_user.reload
        expect(@admin_user.email).to eq(new_attributes[:email])
      end

      it 'assigns the requested admin_user as @admin_user' do
        put :update, {:id => @admin_user.to_param, :admin_user => valid_attributes}
        expect(assigns(:admin_user)).to eq(@admin_user)
      end

      it 'redirects to the admin_user' do
        put :update, {:id => @admin_user.to_param, :admin_user => valid_attributes}

        expect(response).to redirect_to(admin_admin_user_path(@admin_user))
      end
    end

    context 'with invalid params' do
      it 'assigns the admin_user as @admin_user' do
        put :update, {:id => @admin_user.to_param, :admin_user => invalid_attributes}
        expect(assigns(:admin_user)).to eq(@admin_user)
      end

      it 're-renders the "edit" template' do
        put :update, {:id => @admin_user.to_param, :admin_user => invalid_attributes}
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @admin_user = Fabricate :admin_user
    end

    it 'destroys the requested admin_user' do
      expect {
        delete :destroy, {:id => @admin_user.to_param}
      }.to change(AdminUser, :count).by(-1)
    end

    it 'redirects to the AdminUsers list' do
      delete :destroy, {:id => @admin_user.to_param}
      expect(response).to redirect_to(admin_admin_users_path)
    end
  end

end
