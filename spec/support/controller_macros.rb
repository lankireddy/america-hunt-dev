module ControllerMacros
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin_user]
      sign_in Fabricate :admin_user
    end
  end

  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = Fabricate :user
      sign_in user
    end
  end
end