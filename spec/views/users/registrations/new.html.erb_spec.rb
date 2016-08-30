require 'spec_helper'

RSpec.describe 'users/registrations/new', type: :view do
  include_context 'ad_page'
  before(:each) do
    allow(view).to receive(:resource) { (Fabricate.build :user) }
    allow(view).to receive(:resource_name) { :user }
  end

  it 'renders new user form' do
    render
    assert_select 'form[action=?][method=?]', user_registration_path, 'post' do

      assert_select 'input#user_profile_image[name=?]', 'user[profile_image]'

      assert_select 'input#user_first_name[name=?]', 'user[first_name]'

      assert_select 'input#user_last_name[name=?]', 'user[last_name]'

      assert_select 'input#user_phone[name=?]', 'user[phone]'

      assert_select 'input#user_email[name=?]', 'user[email]'

      assert_select 'input#user_address_1[name=?]', 'user[address_1]'

      assert_select 'input#user_city[name=?]', 'user[city]'

      assert_select 'input#user_state[name=?]', 'user[state]'

      assert_select 'input#user_zip[name=?]', 'user[zip]'

      assert_select 'input#user_password[name=?]', 'user[password]'

      assert_select 'input#user_password_confirmation[name=?]', 'user[password_confirmation]'

    end
  end
end
