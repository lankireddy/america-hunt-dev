

RSpec.describe Admin::SpeciesController, type: :controller do
  login_admin
  render_views

  let(:valid_attributes) { (Fabricate.build :species).attributes }

  let(:invalid_attributes) { { name: '' } }

  describe 'GET #index' do
    it 'assigns all species as @species' do
      species = Species.create! valid_attributes
      get :index, {}
      expect(assigns(:species)).to eq([species])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested species as @species' do
      species = Species.create! valid_attributes
      get :show, { id: species.to_param }
      expect(assigns(:species)).to eq(species)
    end
  end

  describe 'GET #new' do
    it 'assigns a new species as @species' do
      get :new, {}
      expect(assigns(:species)).to be_a_new(Species)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested species as @species' do
      species = Species.create! valid_attributes
      get :edit, { id: species.to_param }
      expect(assigns(:species)).to eq(species)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Species' do
        expect {
          post :create, {:species => valid_attributes }
        }.to change(Species, :count).by(1)
      end

      it 'assigns a newly created species as @species' do
        post :create, {:species => valid_attributes }
        expect(assigns(:species)).to be_a(Species)
        expect(assigns(:species)).to be_persisted
      end

      it 'redirects to the created species' do
        post :create, {:species => valid_attributes }
        expect(response).to redirect_to(admin_species_path(Species.last))
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved species as @species' do
        post :create, {:species => invalid_attributes }
        expect(assigns(:species)).to be_a_new(Species)
      end

      it 're-renders the "new" template' do
        post :create, {:species => invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { name: Faker::Commerce.department }
      }

      it 'updates the requested species' do
        species = Species.create! valid_attributes
        put :update, { id: species.to_param, :species => new_attributes}
        species.reload
        expect(species.name).to eq(new_attributes[:name])
      end

      it 'assigns the requested species as @species' do
        species = Species.create! valid_attributes
        put :update, { id: species.to_param, :species => valid_attributes }
        expect(assigns(:species)).to eq(species)
      end

      it 'redirects to the species' do
        species = Species.create! valid_attributes
        put :update, { id: species.to_param, :species => valid_attributes }
        expect(response).to redirect_to(admin_species_path(species))
      end
    end

    context 'with invalid params' do
      it 'assigns the species as @species' do
        species = Species.create! valid_attributes
        put :update, { id: species.to_param, :species => invalid_attributes }
        expect(assigns(:species)).to eq(species)
      end

      it 're-renders the "edit" template' do
        species = Species.create! valid_attributes
        put :update, { id: species.to_param, :species => invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested species' do
      species = Species.create! valid_attributes
      expect {
        delete :destroy, { id: species.to_param }
      }.to change(Species, :count).by(-1)
    end

    it 'redirects to the species list' do
      species = Species.create! valid_attributes
      delete :destroy, { id: species.to_param }
      expect(response).to redirect_to(admin_species_index_path)
    end
  end
end
