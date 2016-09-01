RSpec.describe ReviewsController, type: :controller do

  let!(:location) { Fabricate :location }
  
  let(:valid_attributes) { (Fabricate.build :review).attributes }

  let(:invalid_attributes) { { star_rating: nil } }
  
  let(:valid_session) { {} }

  describe 'GET #index' do
    before do
      location = Fabricate :location
    end

    it 'assigns approved location reviews as @reviews' do
      approved_review = Fabricate :review, location: location, status: 'approved'
      pending_review = Fabricate :review, location: location, status: 'pending'
      get :index, { location_id: location.id}
      expect(assigns(:reviews)).to include approved_review
      expect(assigns(:reviews)).to_not include pending_review

    end

    it 'limits review count to 10' do
      Fabricate.times 15, :review, location: location, status: 'approved'
      get :index, { location_id: location.id}
      expect(assigns(:reviews).count).to eq(10)
    end
  end

  describe 'POST #create' do
    describe 'as unauthorized user' do
      it 'raises unauthorized error' do
        expect do
          post :create, { review: valid_attributes, location_id: location.id, format: 'json' }
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end
    
    describe 'as logged in user' do
      login_user
      
      context 'with valid params' do
        it 'creates a new Review' do
          expect {
            post :create, { review: valid_attributes, location_id: location.id, format: 'json' }, valid_session
          }.to change(Review, :count).by(1)
        end
  
        it 'assigns a newly created review as @review' do
          post :create, { review: valid_attributes, location_id: location.id, format: 'json' }, valid_session
          expect(assigns(:review)).to be_a(Review)
          expect(assigns(:review)).to be_persisted
        end
  
        it 'returns object' do
          post :create, { review: valid_attributes, location_id: location.id, format: 'json' }, valid_session
          expect(response).to be_success
          expect(response.body).to eq(assigns(:review).to_json(include: :submitter))
        end
      end
  
      context 'with invalid params' do
        it 'assigns a newly created but unsaved review as @review' do
          post :create, { review: invalid_attributes, location_id: location.id, format: 'json' }, valid_session
          expect(assigns(:review)).to be_a_new(Review)
        end
  
        it "re-renders the 'new' template" do
          post :create, { review: invalid_attributes, location_id: location.id, format: 'json' }, valid_session
          expect(response.status).to eq(Rack::Utils.status_code(:unprocessable_entity))
        end
      end
    end
  end
end
