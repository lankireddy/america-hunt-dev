feature 'GET /users/login' do
  before do
    @user = Fabricate :user
  end

  context 'homepage login' do
    before do
      visit '/browse'
    end

    context 'correct admin username and password' do
      scenario 'shows the login page when not logged in' do
        expect(page).to have_css('#user_email')
        expect(page).to have_css('#user_password')
      end

      scenario 'allows the user to login' do
        login @user
        expect(page).to have_link('Logout')
        expect(current_path).to eq '/browse'
      end

      scenario 'shows a successful message after logging in' do
        login @user
        expect(page).to have_css('.alert-notice')
        expect(page).to have_content('Signed in successfully.')
      end
    end

    context 'incorrect credentials' do
      scenario 'does not log the user in' do
        login(@user, 'incorrect')
        expect(current_path).to eq new_user_session_path
        expect(page).to_not have_link('Logout')
      end

      scenario 'shows a failure message when failing to login' do
        login @user, 'incorrect'
        expect(current_path).to eq new_user_session_path
        expect(page).to_not have_content('Signed in successfully.')
        expect(page).to have_css('.alert-alert')
      end
    end
  end

  context 'interior page login' do
    let(:location) { Fabricate :location }
    before do
      visit location_path(location)
    end

    scenario 'returns user to previous page on success' do
      login @user
      expect(page).to have_link('Logout')
      expect(current_path).to eq location_path(location)
    end
  end
end
