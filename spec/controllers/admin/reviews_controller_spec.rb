

RSpec.describe Admin::ReviewsController, type: :controller do
  login_admin
  render_views

  let(:valid_attributes) { { status: 'unapproved' } }

  describe 'GET #index' do
    it 'assigns all approved reviews as @reviews' do
      review = Fabricate :review, status: 'approved'
      get :index, {}
      expect(assigns(:reviews)).to eq([review])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested review as @review' do
      review = Fabricate :review
      get :show, { id: review.to_param }
      expect(assigns(:review)).to eq(review)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested review as @review' do
      review = Fabricate :review
      get :edit, { id: review.to_param }
      expect(assigns(:review)).to eq(review)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { status: 'approved' }
      }

      it 'updates the requested review' do
        review = Fabricate :review
        put :update, { id: review.to_param, :review => new_attributes}
        review.reload
        expect(review.status).to eq(new_attributes[:status])
      end

      it 'assigns the requested review as @review' do
        review = Fabricate :review
        put :update, { id: review.to_param, :review => valid_attributes }
        expect(assigns(:review)).to eq(review)
      end

      it 'redirects to the review' do
        review = Fabricate :review
        put :update, { id: review.to_param, :review => valid_attributes }
        expect(response).to redirect_to(admin_review_path(review))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested review' do
      review = Fabricate :review
      expect {
        delete :destroy, { id: review.to_param }
      }.to change(Review, :count).by(-1)
    end

    it 'redirects to the reviews list' do
      review = Fabricate :review
      delete :destroy, { id: review.to_param }
      expect(response).to redirect_to(admin_reviews_path)
    end
  end

  describe 'POST #batch_action' do
    it 'approve action sets status of reviews to approved' do
      fabricated_reviews = Fabricate.times 5, :review, status: 'unapproved'
      post :batch_action, { collection_selection: fabricated_reviews.map(&:id), batch_action: 'approve' }
      reviews = Review.where(id: fabricated_reviews.map(&:id))
      expect(reviews.pluck(:status).uniq).to eq([Review.statuses[:approved]])
    end

    it 'unapprove action sets status of reviews to approved' do
      fabricated_reviews = Fabricate.times 5, :review, status: 'approved'
      post :batch_action, { collection_selection: fabricated_reviews.map(&:id), batch_action: 'unapprove' }
      reviews = Review.where(id: fabricated_reviews.map(&:id))
      expect(reviews.pluck(:status).uniq).to eq([Review.statuses[:unapproved]])
    end
  end
end
