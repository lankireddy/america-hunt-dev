feature 'GET /admin/users/login' do
  before do
    @admin_user = Fabricate :admin_user
    visit new_admin_user_session_path
  end

  context 'correct admin username and password' do
    scenario 'shows the login page when not logged in' do
      expect(page).to have_css('#admin_user_email')
      expect(page).to have_css('#admin_user_password')
    end

    scenario 'allows the user to login' do
      login_admin @admin_user
      expect(page).to have_link('Logout')
      expect(current_path).to eq admin_root_path
    end

    scenario 'shows a successful message after logging in' do
      login_admin @admin_user
      expect(page).to have_css('.flash.flash_notice')
      expect(page).to have_content('Signed in successfully.')
    end
  end

  context 'incorrect credentials' do
    scenario 'does not log the user in' do
      login_admin(@admin_user, 'incorrect')
      expect(current_path).to eq new_admin_user_session_path
      expect(page).to_not have_link('Logout')
    end

    scenario 'shows a failure message when failing to login' do
      login_admin @admin_user, 'incorrect'
      expect(current_path).to eq new_admin_user_session_path
      expect(page).to_not have_content('Signed in successfully.')
      expect(page).to have_css('.flash.flash_alert')
    end
  end
end
