RSpec.describe Admin::AdsController, type: :controller do
  login_admin
  render_views

  let(:valid_attributes) { (Fabricate.build :ad).attributes.merge('slot' => 'sidebar') }

  let(:invalid_attributes) { { name: ''} }

  describe 'GET #index' do
    it 'assigns all ads as @ads' do
      ad = Ad.create! valid_attributes
      get :index, {}
      expect(assigns(:ads)).to eq([ad])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested ad as @ad' do
      ad = Ad.create! valid_attributes
      get :show, { id: ad.to_param }
      expect(assigns(:ad)).to eq(ad)
    end
  end

  describe 'GET #new' do
    it 'assigns a new ad as @ad' do
      get :new, {}
      expect(assigns(:ad)).to be_a_new(Ad)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested ad as @ad' do
      ad = Ad.create! valid_attributes
      get :edit, { id: ad.to_param }
      expect(assigns(:ad)).to eq(ad)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Ad' do
        expect {
          post :create, { ad: valid_attributes}
        }.to change(Ad, :count).by(1)
      end

      it 'assigns a newly created ad as @ad' do
        post :create, { ad: valid_attributes}
        expect(assigns(:ad)).to be_a(Ad)
        expect(assigns(:ad)).to be_persisted
      end

      it 'redirects to the created ad' do
        post :create, { ad: valid_attributes}
        expect(response).to redirect_to(admin_ad_path(Ad.last))
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved ad as @ad' do
        post :create, { ad: invalid_attributes}
        expect(assigns(:ad)).to be_a_new(Ad)
      end

      it 're-renders the "new" template' do
        post :create, { ad: invalid_attributes}
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { name: Faker::Commerce.department }
      }

      it 'updates the requested ad' do
        ad = Ad.create! valid_attributes
        put :update, {:id => ad.to_param, :ad => new_attributes}
        ad.reload
        expect(ad.name).to eq(new_attributes[:name])
      end

      it 'assigns the requested ad as @ad' do
        ad = Ad.create! valid_attributes
        put :update, { id: ad.to_param, ad: valid_attributes }
        expect(assigns(:ad)).to eq(ad)
      end

      it 'redirects to the ad' do
        ad = Ad.create! valid_attributes
        put :update, { id: ad.to_param, ad: valid_attributes }
        expect(response).to redirect_to(admin_ad_path(ad))
      end
    end

    context 'with invalid params' do
      it 'assigns the ad as @ad' do
        ad = Ad.create! valid_attributes
        put :update, { id: ad.to_param, ad: invalid_attributes }
        expect(assigns(:ad)).to eq(ad)
      end

      it 're-renders the "edit" template' do
        ad = Ad.create! valid_attributes
        put :update, { id: ad.to_param, ad: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested ad' do
      ad = Ad.create! valid_attributes
      expect {
        delete :destroy, { id: ad.to_param }
      }.to change(Ad, :count).by(-1)
    end

    it 'redirects to the ads list' do
      ad = Ad.create! valid_attributes
      delete :destroy, { id: ad.to_param }
      expect(response).to redirect_to(admin_ads_path)
    end
  end
end
