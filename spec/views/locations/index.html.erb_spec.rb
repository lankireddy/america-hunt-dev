require 'spec_helper'

RSpec.describe 'locations/index', type: :view do
  let(:locations) { Fabricate.times 2, :location }
  before(:each) do
    assign(:locations, locations)
  end

  it 'renders a list of locations' do
    render
    locations.each do |location|
      expect(rendered).to include(ERB::Util.html_escape(location.name))
    end
  end
end
