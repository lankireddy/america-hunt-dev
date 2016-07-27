feature 'GET /users/sign_up' do
  before do
    @user = Fabricate :user
    visit new_user_registration_path
  end

  context 'correct username and password' do
    scenario 'shows the login page when not logged in' do
      expect(page).to have_css('#user_email')
      expect(page).to have_css('#user_password')
    end

    scenario 'allows the user to sign up and shows a successful message' do
      signup '#{SecureRandom.hex(6)}@test.com', 'metova123'
      expect(page).to have_css('.alert-notice')
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end
  context 'duplicate username' do
    scenario 'shows a failure message after signing up' do
      signup @user.email, 'metova'
      expect(page).to have_content('has already been taken')
      expect(page).to have_content('minimum is 8 characters')
    end
  end

  def signup(email, password)
    visit new_user_registration_path
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    find('input[type=submit]').click
  end

end
