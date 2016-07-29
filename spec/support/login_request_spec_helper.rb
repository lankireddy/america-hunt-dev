module LoginHelper
  def login(user, password = nil)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: (password || user.password)
    find('input[type=submit]').click
  end

  def login_admin(user, password = nil)
    visit new_admin_user_session_path
    fill_in 'admin_user_email', with: user.email
    fill_in 'admin_user_password', with: (password || user.password)
    find('input[type=submit]').click
  end

  def logout
    click_link 'Logout'
  end
end

RSpec.configure do |config|
  config.include LoginHelper
end
