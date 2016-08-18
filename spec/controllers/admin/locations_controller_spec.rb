

RSpec.describe Admin::LocationsController, type: :controller do
  login_admin
  render_views

  let!(:valid_attributes) { (Fabricate.build :location).attributes.merge('status' => 'approved') }

  let(:invalid_attributes) { { name: ''} }

  describe 'GET #index' do
    it 'assigns all locations as @locations' do
      location = Location.create! valid_attributes
      get :index, {}
      expect(assigns(:locations)).to eq([location])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested location as @location' do
      location = Location.create! valid_attributes
      get :show, {:id => location.to_param}
      expect(assigns(:location)).to eq(location)
    end
  end

  describe 'GET #new' do
    it 'assigns a new location as @location' do
      get :new, {}
      expect(assigns(:location)).to be_a_new(Location)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested location as @location' do
      location = Location.create! valid_attributes
      get :edit, {:id => location.to_param}
      expect(assigns(:location)).to eq(location)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Location' do
        expect {
          post :create, {:location => valid_attributes}
        }.to change(Location, :count).by(1)
      end

      it 'assigns a newly created location as @location' do
        post :create, {:location => valid_attributes}
        expect(assigns(:location)).to be_a(Location)
        expect(assigns(:location)).to be_persisted
      end

      it 'assigns categories based on ids' do
        categories = Fabricate.times 2, :category
        binding.pry
        post :create, { location: valid_attributes.merge({ category_ids: categories.map(&:id) }) }
        location = assigns(:location)
        expect(location.categories.count).to eq(2)
        expect(location.category_ids).to eq(categories.map(&:id))
      end

      it 'assigns species based on ids' do
        species = Fabricate.times 2, :species
        post :create, { location: valid_attributes.merge({ species_ids: species.map(&:id) }) }
        location = assigns(:location)
        expect(location.species.count).to eq(2)
        expect(location.species_ids).to eq(species.map(&:id))
      end

      it 'redirects to the created location' do
        post :create, {:location => valid_attributes}
        expect(response).to redirect_to(admin_location_path(Location.last))
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved location as @location' do
        post :create, {:location => invalid_attributes}
        expect(assigns(:location)).to be_a_new(Location)
      end

      it 're-renders the "new" template' do
        post :create, {:location => invalid_attributes}
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { name: Faker::Company.name }
      }

      it 'updates the requested location' do
        location = Location.create! valid_attributes
        put :update, {:id => location.to_param, :location => new_attributes}
        location.reload
        expect(location.name).to eq(new_attributes[:name])
      end

      it 'assigns the requested location as @location' do
        location = Location.create! valid_attributes
        put :update, {:id => location.to_param, :location => valid_attributes}
        expect(assigns(:location)).to eq(location)
      end

      it 'changes category list to reflect ids' do
        location = Location.create! valid_attributes
        location.categories << (Fabricate :category)
        new_categories = Fabricate.times 2, :category
        put :update, {:id => location.to_param, location: { category_ids: new_categories.map(&:id) }}
        location.reload
        expect(location.categories).to eq(new_categories)
      end

      it 'changes species list to reflect ids' do
        location = Location.create! valid_attributes
        location.species << (Fabricate :species)
        new_species = Fabricate.times 2, :species
        put :update, {:id => location.to_param, location: { species_ids: new_species.map(&:id) }}
        location.reload
        expect(location.species).to match_array(new_species)
      end

      it 'redirects to the location' do
        location = Location.create! valid_attributes
        put :update, {:id => location.to_param, :location => valid_attributes}
        expect(response).to redirect_to(admin_location_path(location))
      end
    end

    context 'with invalid params' do
      it 'assigns the location as @location' do
        location = Location.create! valid_attributes
        put :update, {:id => location.to_param, :location => invalid_attributes}
        expect(assigns(:location)).to eq(location)
      end

      it 're-renders the "edit" template' do
        location = Location.create! valid_attributes
        put :update, {:id => location.to_param, :location => invalid_attributes}
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested location' do
      location = Location.create! valid_attributes
      expect {
        delete :destroy, {:id => location.to_param}
      }.to change(Location, :count).by(-1)
    end

    it 'redirects to the locations list' do
      location = Location.create! valid_attributes
      delete :destroy, {:id => location.to_param}
      expect(response).to redirect_to(admin_locations_path)
    end
  end
end
