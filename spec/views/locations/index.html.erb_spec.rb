require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        :travelier_id => 1,
        :name => "Name",
        :website => "MyText",
        :contact_page => "MyText",
        :phone => "Phone",
        :email => "Email",
        :address_1 => "Address 1",
        :address_2 => "Address 2",
        :city => "City",
        :zip => "Zip",
        :lat => "9.99",
        :long => "9.99",
        :featured => false,
        :follow_up => false,
        :description => "MyText"
      ),
      Location.create!(
        :travelier_id => 1,
        :name => "Name",
        :website => "MyText",
        :contact_page => "MyText",
        :phone => "Phone",
        :email => "Email",
        :address_1 => "Address 1",
        :address_2 => "Address 2",
        :city => "City",
        :zip => "Zip",
        :lat => "9.99",
        :long => "9.99",
        :featured => false,
        :follow_up => false,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of locations" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Address 1".to_s, :count => 2
    assert_select "tr>td", :text => "Address 2".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
