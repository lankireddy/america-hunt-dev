
RSpec.describe ContactMessagesController, type: :controller do

  let(:valid_attributes) { (Fabricate.build :contact_message).attributes }

  let(:invalid_attributes) { { body: ''} }


  describe 'GET #new' do
    it 'assigns a new contact_message as @contact_message' do
      get :new, {}
      expect(assigns(:contact_message)).to be_a_new(ContactMessage)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ContactMessage' do
        expect {
          post :create, { contact_message: valid_attributes }
        }.to change(ContactMessage, :count).by(1)
      end

      it 'assigns a newly created contact_message as @contact_message' do
        post :create, { contact_message: valid_attributes }
        expect(assigns(:contact_message)).to be_a(ContactMessage)
        expect(assigns(:contact_message)).to be_persisted
      end

      it 'redirects to the thank you page' do
        post :create, { contact_message: valid_attributes }
        expect(response).to render_template('create')
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved contact_message as @contact_message' do
        post :create, { contact_message: invalid_attributes }
        expect(assigns(:contact_message)).to be_a_new(ContactMessage)
      end

      it 're-renders the \'new\' template' do
        post :create, { contact_message: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end
end
