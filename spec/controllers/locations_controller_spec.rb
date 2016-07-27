require 'spec_helper'

RSpec.describe LocationsController, type: :controller do

  let!(:valid_attributes) { (Fabricate.build :location).attributes }

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
