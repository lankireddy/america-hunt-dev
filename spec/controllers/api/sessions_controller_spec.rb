describe API::SessionsController do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:api_user]
  end

  describe 'POST create' do
    specify 'Login and get the users auth token' do
      post :create, user: { email: 'test@metova.com', password: 'password' }
      expect(response).to have_http_status 201
      expect(json).to include :id, :email, :authentication_token
    end

    specify 'Login with wrong password' do
      post :create, user: { email: 'test@metova.com', password: 'incorrect' }
      expect(response).to have_http_status 401
      expect(json[:errors]).to include 'Invalid email or password.'
    end
  end
end
