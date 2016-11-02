require 'spec_helper'

RSpec.describe 'locations/_filters', type: :view do
  before(:each) do
    @state_alpha2 = 'AR'
    top_level_species = Fabricate.times 5, :top_level_species
    top_level_species.each do |species|
      Fabricate.times 2, :species, parent_id: species.id
    end
    @top_level_species = Species.top_level
  end

  it 'renders location search form' do
    render
    expect(rendered).to have_selector("form[action='#{state_locations_path(state_alpha2: @state_alpha2)}']")
    expect(rendered).to have_selector('input[type="submit"]')
  end
end
