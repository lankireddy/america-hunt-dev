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
    it 'assigns nearby locations as @locations' do
      far_location = Fabricate :location, state: 'Alaska', city:'Fairbanks', address_1: '100 Main St.'
      close_locations = [
          (Fabricate :location, state: 'Tennessee', city:'Franklin', address_1: '3301 Aspen Grove Dr'),
          (Fabricate :location, state: 'Tennessee', city:'Franklin', address_1: '120 4th Ave S')
      ]
      query = 'Franklin, TN'
      allow(Location).to receive(:near) { close_locations }
      expect(Location).to receive(:near).with(query, LocationsController::DEFAULT_SEARCH_RADIUS)
      get :index, { query: query }
      expect(assigns(:locations)).to include(*close_locations)
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
