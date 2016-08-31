

RSpec.describe Admin::HomepageVideosController, type: :controller do
  login_admin
  render_views

  let(:valid_attributes) { (Fabricate.build :homepage_video).attributes }

  let(:invalid_attributes) { { name: '' } }

  describe 'GET #index' do
    it 'assigns all homepage videos as @homepage_videos' do
      homepage_video = HomepageVideo.create! valid_attributes.merge({ published: true})
      get :index, {}
      expect(assigns(:homepage_videos)).to eq([homepage_video])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested homepage video as @homepage_video' do
      homepage_video = HomepageVideo.create! valid_attributes
      get :show, { id: homepage_video.to_param }
      expect(assigns(:homepage_video)).to eq(homepage_video)
    end
  end

  describe 'GET #new' do
    it 'assigns a new homepage video as @homepage_video' do
      get :new, {}
      expect(assigns(:homepage_video)).to be_a_new(HomepageVideo)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested homepage video as @homepage_video' do
      homepage_video = HomepageVideo.create! valid_attributes
      get :edit, { id: homepage_video.to_param }
      expect(assigns(:homepage_video)).to eq(homepage_video)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new HomepageVideo' do
        expect {
          post :create, { homepage_video: valid_attributes }
        }.to change(HomepageVideo, :count).by(1)
      end

      it 'assigns a newly created homepage video as @homepage_video' do
        post :create, { homepage_video: valid_attributes }
        expect(assigns(:homepage_video)).to be_a(HomepageVideo)
        expect(assigns(:homepage_video)).to be_persisted
      end

      it 'redirects to the created homepage video' do
        post :create, { homepage_video: valid_attributes }
        expect(response).to redirect_to(admin_homepage_video_path(HomepageVideo.last))
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved homepage video as @homepage_video' do
        post :create, { homepage_video: invalid_attributes }
        expect(assigns(:homepage_video)).to be_a_new(HomepageVideo)
      end

      it 're-renders the "new" template' do
        post :create, { homepage_video: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { name: Faker::Commerce.department }
      }

      it 'updates the requested homepage video' do
        homepage_video = HomepageVideo.create! valid_attributes
        put :update, { id: homepage_video.to_param, homepage_video: new_attributes}
        homepage_video.reload
        expect(homepage_video.name).to eq(new_attributes[:name])
      end

      it 'assigns the requested homepage video as @homepage_video' do
        homepage_video = HomepageVideo.create! valid_attributes
        put :update, { id: homepage_video.to_param, homepage_video: valid_attributes }
        expect(assigns(:homepage_video)).to eq(homepage_video)
      end

      it 'redirects to the homepage video' do
        homepage_video = HomepageVideo.create! valid_attributes
        put :update, { id: homepage_video.to_param, homepage_video: valid_attributes }
        expect(response).to redirect_to(admin_homepage_video_path(homepage_video))
      end
    end

    context 'with invalid params' do
      it 'assigns the homepage video as @homepage_video' do
        homepage_video = HomepageVideo.create! valid_attributes
        put :update, { id: homepage_video.to_param, homepage_video: invalid_attributes }
        expect(assigns(:homepage_video)).to eq(homepage_video)
      end

      it 're-renders the "edit" template' do
        homepage_video = HomepageVideo.create! valid_attributes
        put :update, { id: homepage_video.to_param, homepage_video: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested homepage video' do
      homepage_video = HomepageVideo.create! valid_attributes
      expect {
        delete :destroy, { id: homepage_video.to_param }
      }.to change(HomepageVideo, :count).by(-1)
    end

    it 'redirects to the homepage videos list' do
      homepage_video = HomepageVideo.create! valid_attributes
      delete :destroy, { id: homepage_video.to_param }
      expect(response).to redirect_to(admin_homepage_videos_path)
    end
  end
end
