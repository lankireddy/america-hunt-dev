

RSpec.describe Admin::UsersController, type: :controller do
  login_admin
  render_views

  let(:valid_attributes) { (Fabricate.build :user).attributes.except(:id).merge({ password: 'testPassword'}) }
  let(:invalid_attributes) { { email: 'invalid_email.com' } }


  describe 'GET #index' do
    it 'assigns all Users as @Users' do
      user = Fabricate :user
      get :index, {}
      expect(assigns(:users)).to include(*User.all)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user as @user' do
      user = Fabricate :user
      get :show, {:id => user.to_param}
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user as @user' do
      user = Fabricate :user
      get :edit, {:id => user.to_param}
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @user = Fabricate :user
    end
    context 'with valid params' do
      let(:new_attributes) {
        { email: 'fake_email@email.com' }
      }


      it 'updates the requested user' do
        put :update, {:id => @user.to_param, :user => new_attributes}
        @user.reload
        expect(@user.email).to eq(new_attributes[:email])
      end

      it 'assigns the requested user as @user' do
        put :update, {:id => @user.to_param, :user => valid_attributes}
        expect(assigns(:user)).to eq(@user)
      end

      it 'redirects to the user' do
        put :update, {:id => @user.to_param, :user => valid_attributes}

        expect(response).to redirect_to(admin_user_path(@user))
      end
    end

    context 'with invalid params' do
      it 'assigns the user as @user' do
        put :update, {:id => @user.to_param, :user => invalid_attributes}
        expect(assigns(:user)).to eq(@user)
      end

      it 're-renders the "edit" template' do
        put :update, {:id => @user.to_param, :user => invalid_attributes}
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @user = Fabricate :user
    end

    it 'destroys the requested user' do
      expect {
        delete :destroy, {:id => @user.to_param}
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the Users list' do
      delete :destroy, {:id => @user.to_param}
      expect(response).to redirect_to(admin_users_path)
    end
  end

end
