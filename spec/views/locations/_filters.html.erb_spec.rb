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
    expect(rendered).to have_selector('form')
    expect(rendered).to have_selector('input[type="hidden"][name="state_alpha2"]', visible: false)
    expect(rendered).to have_selector('input[type="submit"]')
  end

  it 'hidden state_alpha2 field has current location in it' do
    render
    expect(rendered).to have_selector("input[type='hidden'][name='state_alpha2'][value='#{@state_alpha2}']", visible: false)
  end
end
