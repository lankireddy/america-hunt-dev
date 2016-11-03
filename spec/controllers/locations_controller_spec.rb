

RSpec.describe LocationsController, type: :controller do

  let!(:valid_attributes) { (Fabricate.build :location).attributes }

  let(:invalid_attributes) { { name: '' } }


  describe 'GET #index' do

    it 'assigns all top level species as @top_level_species' do
      species = Fabricate :species
      get :index, { state_alpha2: 'ID' }
      expect(assigns(:top_level_species)).to eq([species])
    end

    it 'assigns current species_ids as @species_ids' do
      parent_species = Fabricate :species, name: 'Pokemon'
      species_list = Fabricate.times 5, :species, parent_id: parent_species.id
      get :index, { species_ids: species_list.map(&:id), state_alpha2: 'ID' }
      expect(assigns(:species_ids)).to eq(species_list.map{ |species| species.id.to_s })
    end

    describe 'with state_alpha2' do
      before do
        far_location = Fabricate :location, state: 'Alaska', city: 'Fairbanks', address_1: '100 Main St.'
        city = 'Franklin'
        state = 'TN'
        @close_locations = [
            (Fabricate :location, state: state, city: city, address_1: '3301 Aspen Grove Dr'),
            (Fabricate :location, state: state, city: 'other city', address_1: '120 4th Ave S'),
            (Fabricate :location, state: state, city: city, address_1: '121 4th Ave S'),
            (Fabricate :location, state: state, city: city, address_1: '122 4th Ave S')
        ]
        @state_alpha2 = state
      end

      it 'scopes results to approved status' do
        expect(Location).to receive(:approved)  { Location.where(id: @close_locations.map(&:id)) }
        get :index, { state_alpha2: @state_alpha2 }
      end

      describe 'no species' do
        before do
          get :index, { state_alpha2: @state_alpha2 }
        end

        it 'assigns current state as @state_alpha2' do
          expect(assigns(:state_alpha2)).to eq(@state_alpha2)
        end

        it 'assigns all locations in state as @locations' do
          expect(assigns(:locations)).to include(*@close_locations)
        end

        it 'assigns title, page title, and description that include state name' do
          expect(assigns(:title)).to include('Tennessee')
          expect(assigns(:page_title)).to include('Tennessee')
          expect(assigns(:page_description)).to include('Tennessee')
        end
      end

      describe 'filter by species' do
        before do
          @matching_specific_species = Fabricate.times 2, :species
          @non_matching_specific_species = Fabricate.times 2, :species

          @close_locations[0].species << @matching_specific_species[1]
          @close_locations[1].species << @matching_specific_species[0]
          @close_locations[2].species << @non_matching_specific_species[1]
          @close_locations[3].species << @non_matching_specific_species[0]
        end

        it 'limits @locations by species when species ids are present' do
          get :index, { state_alpha2: @state_alpha2, species_ids: @matching_specific_species.map(&:id) }
          expect(assigns(:locations)).to match_array([@close_locations[0], @close_locations[1]])
        end
      end
    end
  end

  describe 'GET #show' do
    let(:location) { Location.create! valid_attributes }

    it 'assigns the requested location as @location' do
      get :show, { id: location.to_param }
      expect(assigns(:location)).to eq(location)
    end

    it 'assigns request referrer to @previous_page' do
      previous_page = state_locations_path(state_alpha2: 'TN')
      expect(controller.request).to receive(:referer).and_return(previous_page)
      get :show, { id: location.to_param }
      expect(assigns(:previous_page)).to eq(previous_page)
    end

    it 'assigns the location name as @page_title' do
      get :show, { id: location.to_param }
      expect(assigns(:page_title)).to eq('America Hunt: ' + location.name)
    end

    it 'assigns the location excerpt as @page_description' do
      get :show, { id: location.to_param }
      expect(assigns(:page_description)).to eq(location.excerpt)
    end

    it 'assigns the friendly url as @page_url' do
      get :show, { id: location.to_param }
      expect(assigns(:page_url)).to include(location_path(location.to_param))
    end

    it 'redirects users that access via id instead of slug' do
      get :show, { id: location.id }
      expect(response).to redirect_to(location_path(location.to_param))
    end
  end

  describe 'GET #new' do
    it 'assigns a new location as @location' do
      get :new, {}
      expect(assigns(:location)).to be_a_new(Location)
    end

    it 'assigns all weapon types as @weapon_types' do
      weapon_type = Fabricate :weapon_type
      get :new, {}
      expect(assigns(:weapon_types)).to eq([weapon_type])
    end
  end

  describe 'POST #create' do
    describe 'as unauthorized user' do
      it 'raises unauthorized error' do
        expect do
          post :create, { location: valid_attributes }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end
    describe 'as logged in user' do
      login_user

      context 'with valid params' do
        it 'creates a new Location' do
          expect {
            post :create, { location: valid_attributes }
          }.to change(Location, :count).by(1)
        end

        it 'assigns a newly created location as @location' do
          post :create, { location: valid_attributes }
          expect(assigns(:location)).to be_a(Location)
          expect(assigns(:location)).to be_persisted
        end

        it 'newly created location has pending status' do
          post :create, { location: valid_attributes }
          expect(assigns(:location).status).to eq('pending')
        end

        it 'renders the "create" template' do
          post :create, { location: valid_attributes }
          expect(response).to render_template('create')
        end
      end

      context 'with invalid params' do
        it 'assigns a newly created but unsaved location as @location' do
          post :create, { location: invalid_attributes }
          expect(assigns(:location)).to be_a_new(Location)
        end

        it 're-renders the "new" template' do
          post :create, { location: invalid_attributes }
          expect(response).to render_template('new')
        end
      end
    end

  end
end
