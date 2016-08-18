

RSpec.describe Admin::WeaponTypesController, type: :controller do
  login_admin
  render_views

  let(:valid_attributes) { (Fabricate.build :weapon_type).attributes }

  let(:invalid_attributes) { { name: ''} }

  describe 'GET #index' do
    it 'assigns all weapon_types as @weapon_types' do
      weapon_type = WeaponType.create! valid_attributes
      get :index, {}
      expect(assigns(:weapon_types)).to eq([weapon_type])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested weapon_type as @weapon_type' do
      weapon_type = WeaponType.create! valid_attributes
      get :show, {:id => weapon_type.to_param}
      expect(assigns(:weapon_type)).to eq(weapon_type)
    end
  end

  describe 'GET #new' do
    it 'assigns a new weapon_type as @weapon_type' do
      get :new, {}
      expect(assigns(:weapon_type)).to be_a_new(WeaponType)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested weapon_type as @weapon_type' do
      weapon_type = WeaponType.create! valid_attributes
      get :edit, {:id => weapon_type.to_param}
      expect(assigns(:weapon_type)).to eq(weapon_type)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new WeaponType' do
        expect {
          post :create, {:weapon_type => valid_attributes}
        }.to change(WeaponType, :count).by(1)
      end

      it 'assigns a newly created weapon_type as @weapon_type' do
        post :create, {:weapon_type => valid_attributes}
        expect(assigns(:weapon_type)).to be_a(WeaponType)
        expect(assigns(:weapon_type)).to be_persisted
      end

      it 'redirects to the created weapon_type' do
        post :create, {:weapon_type => valid_attributes}
        expect(response).to redirect_to(admin_weapon_type_path(WeaponType.last))
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved weapon_type as @weapon_type' do
        post :create, {:weapon_type => invalid_attributes}
        expect(assigns(:weapon_type)).to be_a_new(WeaponType)
      end

      it 're-renders the "new" template' do
        post :create, {:weapon_type => invalid_attributes}
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { name: Faker::Commerce.department }
      }

      it 'updates the requested weapon_type' do
        weapon_type = WeaponType.create! valid_attributes
        put :update, {:id => weapon_type.to_param, :weapon_type => new_attributes}
        weapon_type.reload
        expect(weapon_type.name).to eq(new_attributes[:name])
      end

      it 'assigns the requested weapon_type as @weapon_type' do
        weapon_type = WeaponType.create! valid_attributes
        put :update, {:id => weapon_type.to_param, :weapon_type => valid_attributes}
        expect(assigns(:weapon_type)).to eq(weapon_type)
      end

      it 'redirects to the weapon_type' do
        weapon_type = WeaponType.create! valid_attributes
        put :update, {:id => weapon_type.to_param, :weapon_type => valid_attributes}
        expect(response).to redirect_to(admin_weapon_type_path(weapon_type))
      end
    end

    context 'with invalid params' do
      it 'assigns the weapon_type as @weapon_type' do
        weapon_type = WeaponType.create! valid_attributes
        put :update, {:id => weapon_type.to_param, :weapon_type => invalid_attributes}
        expect(assigns(:weapon_type)).to eq(weapon_type)
      end

      it 're-renders the "edit" template' do
        weapon_type = WeaponType.create! valid_attributes
        put :update, {:id => weapon_type.to_param, :weapon_type => invalid_attributes}
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested weapon_type' do
      weapon_type = WeaponType.create! valid_attributes
      expect {
        delete :destroy, {:id => weapon_type.to_param}
      }.to change(WeaponType, :count).by(-1)
    end

    it 'redirects to the weapon_types list' do
      weapon_type = WeaponType.create! valid_attributes
      delete :destroy, {:id => weapon_type.to_param}
      expect(response).to redirect_to(admin_weapon_types_path)
    end
  end
end
