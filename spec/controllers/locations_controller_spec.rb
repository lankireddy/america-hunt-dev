

RSpec.describe LocationsController, type: :controller do

  let!(:valid_attributes) { (Fabricate.build :location).attributes }

  let(:invalid_attributes) { { name: '' } }


  describe 'GET #index' do
    it 'assigns no locations to @locations when there is no query' do
      location = Location.create! valid_attributes
      get :index, {}
      expect(assigns(:locations)).to eq([])
    end

    it 'assigns all categories as @categories' do
      category = Fabricate :category
      get :index, {}
      expect(assigns(:categories)).to eq([category])
    end

    it 'assigns current category id as @category_id' do
      category = Fabricate :category
      get :index, { category_id: category.id}
      expect(assigns(:category_id)).to eq(category.id.to_s)
    end

    it 'assigns all top level species as @top_level_species' do
      species = Fabricate :species
      get :index, {}
      expect(assigns(:top_level_species)).to eq([species])
    end

    it 'assigns current top_level_species_ids as @top_level_species_ids' do
      species_list = Fabricate.times 5, :species
      get :index, { top_level_species_ids: species_list.map(&:id) }
      expect(assigns(:top_level_species_ids)).to eq(species_list.map{ |species| species.id.to_s })
    end

    it 'assigns current species_ids as @species_ids' do
      parent_species = Fabricate :species, name: 'Pokemon'
      species_list = Fabricate.times 5, :species, parent_id: parent_species.id
      get :index, { species_ids: species_list.map(&:id) }
      expect(assigns(:species_ids)).to eq(species_list.map{ |species| species.id.to_s })
    end

    it 'assigns current weapon type id as @weapon_type_id' do
      weapon_type = Fabricate :weapon_type
      get :index, { weapon_type_id: weapon_type.id}
      expect(assigns(:weapon_type_id)).to eq(weapon_type.id.to_s)
    end

    it 'assigns all weapon types as @weapon_types' do
      weapon_type = Fabricate :weapon_type
      get :index, {}
      expect(assigns(:weapon_types)).to eq([weapon_type])
    end

    describe 'with location query' do
      before do
        far_location = Fabricate :location, state: 'Alaska', city: 'Fairbanks', address_1: '100 Main St.'
        city = 'Franklin'
        state = 'TN'
        @close_locations = [
            (Fabricate :location, state: state, city: city, address_1: '3301 Aspen Grove Dr'),
            (Fabricate :location, state: state, city: city, address_1: '120 4th Ave S'),
            (Fabricate :location, state: state, city: city, address_1: '121 4th Ave S'),
            (Fabricate :location, state: state, city: city, address_1: '122 4th Ave S')
        ]
        @query = [city, state].join(', ')
        allow(Location).to receive(:near) { Location.where(id: @close_locations.map(&:id)) }
      end

      it 'scopes results to approved status' do
        expect(Location).to receive(:approved)  { Location.where(id: @close_locations.map(&:id)) }
        get :index, { query: @query}
      end

      it 'assigns current query as @query' do
        get :index, { query: @query}
        expect(assigns(:query)).to eq(@query)
      end

      it 'assigns nearby locations as @locations' do
        expect(Location).to receive(:near).with(@query, LocationsController::DEFAULT_SEARCH_RADIUS)
        get :index, { query: @query, category_id: '' }
        expect(assigns(:locations)).to include(*@close_locations)
      end

      it 'limits @locations to a category when category id is present' do
        category = Fabricate :category
        @close_locations[0].categories << category
        get :index, { query: @query, category_id: category.id }
        expect(assigns(:locations)).to eq([@close_locations[0]])
      end

      it 'limits @locations to a weapon_type when weapon_type id is present' do
        weapon_type = Fabricate :weapon_type
        @close_locations[3].weapon_types << weapon_type
        get :index, { query: @query, weapon_type_id: weapon_type.id }
        expect(assigns(:locations)).to eq([@close_locations[3]])
      end

      describe 'filter by species' do
        before do
          @selected_top_level_species = Fabricate :species, name: 'Pokemon'
          @matching_specific_species = Fabricate.times 2, :species, parent_id: @selected_top_level_species.id
          @not_selected_top_level_species = Fabricate :species, name: 'UnPokemon'
          @non_matching_specific_species = Fabricate.times 2, :species, parent_id: @not_selected_top_level_species.id

          @close_locations[0].species << @matching_specific_species[1]
          @close_locations[1].species << @matching_specific_species[0]
          @close_locations[2].species << @non_matching_specific_species[1]
          @close_locations[3].species << @non_matching_specific_species[0]
        end

        it 'limits @locations by species within top level species when top level species ids are present' do
          get :index, { query: @query, top_level_species_ids: [@selected_top_level_species.id] }
          expect(assigns(:locations)).to match_array([@close_locations[0],@close_locations[1]])
        end

        it 'limits @locations by species when species ids are present' do
          get :index, { query: @query, species_ids: @matching_specific_species.map(&:id) }
          expect(assigns(:locations)).to match_array([@close_locations[0],@close_locations[1]])
        end
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested location as @location' do
      location = Location.create! valid_attributes
      get :show, { id: location.to_param }
      expect(assigns(:location)).to eq(location)
    end
    it 'assigns request referrer to @previous_page' do
      previous_page = '/locations?query=Franklin, TN'
      expect(controller.request).to receive(:referer).and_return(previous_page)
      location = Location.create! valid_attributes
      get :show, { id: location.to_param }
      expect(assigns(:previous_page)).to eq(previous_page)
    end
    it 'assigns the location name as @page_title' do
      location = Location.create! valid_attributes
      get :show, { id: location.to_param }
      expect(assigns(:page_title)).to eq('America Hunt: ' + location.name)
    end
    it 'assigns the location excerpt as @page_description' do
      location = Location.create! valid_attributes
      get :show, { id: location.to_param }
      expect(assigns(:page_description)).to eq(location.excerpt)
    end
  end

  describe 'GET #new' do
    it 'assigns a new location as @location' do
      get :new, {}
      expect(assigns(:location)).to be_a_new(Location)
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
