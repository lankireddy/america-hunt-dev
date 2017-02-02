

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

    describe 'profile image upload' do
      it 'saves the attached file' do
        fill_form '#{SecureRandom.hex(6)}@test.com', 'metova123'
        within('form.user-registration-form') do
          attach_file('user_profile_image', File.absolute_path("#{Rails.root}/spec/support/files/4.jpg"))

          find('input[type=submit]').click
        end
        expect(page).to have_css('.alert-notice')
        expect(page).to have_content('Welcome! You have signed up successfully.')

        new_user = User.order(:created_at).last
        expect(new_user.profile_image.url).to include('4.jpg')
      end
    end
  end
  context 'duplicate username' do
    scenario 'shows a failure message after signing up' do
      signup @user.email, 'metova'
      expect(page).to have_content('has already been taken')
      expect(page).to have_content('minimum is 8 characters')
    end
  end

  def signup(email, password, first_name: @user.first_name, last_name: @user.last_name)
    visit new_user_registration_path
    fill_form(email, password, first_name: first_name, last_name: last_name)
    within('.user-registration-form') do
      find('input[type=submit]').click
    end
  end

  def fill_form(email, password, first_name: @user.first_name, last_name: @user.last_name)
    within('.user-registration-form') do
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      fill_in 'user_first_name', with: first_name
      fill_in 'user_last_name', with: last_name
    end
  end
end
