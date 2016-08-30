require 'spec_helper'

RSpec.describe 'locations/create', type: :view do
  include_context 'ad_page'

  before(:each) do
    @location = Fabricate :location
  end

  it 'displays thank you message' do
    render
    expect(rendered).to include 'Thank you'
  end

end
