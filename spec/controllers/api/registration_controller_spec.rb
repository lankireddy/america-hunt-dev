describe API::RegistrationsController do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:api_user]
  end

  describe 'POST create' do
    specify 'Create a user but does not activate them' do
      post :create, user: { email: 'new.user@metova.com', password: 'password' }
      expect(response).to have_http_status 201
      expect(json[:authentication_token]).to be_present
      User.last.tap do |user|
        expect(user.email).to eq 'new.user@metova.com'
      end
    end
  end
end
