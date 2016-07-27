require 'spec_helper'

RSpec.describe 'locations/new', type: :view do
  before(:each) do
    assign(:location, (Fabricate.build :location))
  end

  it 'renders new location form' do
    render

    assert_select 'form[action=?][method=?]', locations_path, 'post' do
      
      assert_select 'input#location_name[name=?]', 'location[name]'

      assert_select 'textarea#location_website[name=?]', 'location[website]'

      assert_select 'textarea#location_contact_page[name=?]', 'location[contact_page]'

      assert_select 'input#location_phone[name=?]', 'location[phone]'

      assert_select 'input#location_email[name=?]', 'location[email]'

      assert_select 'input#location_address_1[name=?]', 'location[address_1]'

      assert_select 'input#location_address_2[name=?]', 'location[address_2]'

      assert_select 'input#location_city[name=?]', 'location[city]'

      assert_select 'input#location_zip[name=?]', 'location[zip]'

      assert_select 'input#location_lat[name=?]', 'location[lat]'

      assert_select 'input#location_long[name=?]', 'location[long]'

      assert_select 'input#location_featured[name=?]', 'location[featured]'

      assert_select 'input#location_follow_up[name=?]', 'location[follow_up]'

      assert_select 'textarea#location_description[name=?]', 'location[description]'
    end
  end
end
