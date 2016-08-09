require 'spec_helper'

RSpec.describe LocationsController, type: :controller do

  let!(:valid_attributes) { (Fabricate.build :location).attributes }

  let(:invalid_attributes) { { name: ''} }


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

    describe 'with location query' do
      before do
        far_location = Fabricate :location, state: 'Alaska', city:'Fairbanks', address_1: '100 Main St.'
        city = 'Franklin'
        state = 'TN'
        @close_locations = [
            (Fabricate :location, state: state, city: city, address_1: '3301 Aspen Grove Dr'),
            (Fabricate :location, state: state, city: city, address_1: '120 4th Ave S')
        ]
        @query = [city, state].join(', ')
        allow(Location).to receive(:near) { Location.where(id: @close_locations.map(&:id)) }
      end

      it 'assigns current query as @query' do
        get :index, { query: @query}
        expect(assigns(:query)).to eq(@query)
      end

      it 'assigns nearby locations as @locations' do
        expect(Location).to receive(:near).with(@query, LocationsController::DEFAULT_SEARCH_RADIUS)
        get :index, { query: @query, category_id:'' }
        expect(assigns(:locations)).to include(*@close_locations)
      end

      it 'limits @locations to a category when category id is present' do
        category = Fabricate :category
        @close_locations[0].categories << category
        get :index, { query: @query, category_id: category.id }
        expect(assigns(:locations)).to eq([@close_locations[0]])
      end
    end

  end

  describe 'GET #show' do
    it 'assigns the requested location as @location' do
      location = Location.create! valid_attributes
      get :show, {:id => location.to_param}
      expect(assigns(:location)).to eq(location)
    end
    it 'assigns request referrer to @previous_page' do
      previous_page = '/locations?query=Franklin, TN'
      expect(controller.request).to receive(:referer).and_return(previous_page)
      location = Location.create! valid_attributes
      get :show, {:id => location.to_param}
      expect(assigns(:previous_page)).to eq(previous_page)
    end
    it 'assigns the location name as @page_title' do
      location = Location.create! valid_attributes
      get :show, {:id => location.to_param}
      expect(assigns(:page_title)).to eq('America Hunt: ' + location.name)
    end
    it 'assigns the location excerpt as @page_description' do
      location = Location.create! valid_attributes
      get :show, {:id => location.to_param}
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

      it 'redirects to the created location' do
        post :create, {:location => valid_attributes}
        expect(response).to redirect_to(Location.last)
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
end
