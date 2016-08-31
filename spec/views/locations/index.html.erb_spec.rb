require 'spec_helper'

RSpec.describe 'locations/index', type: :view do
  include_context 'ad_page'
  let(:locations) { Fabricate.times 15, :location }
  before(:each) do
    categories = Fabricate.times 5, :category
    @categories = Category.where(id: categories.map(&:id))
    @locations = Location.where(id: locations.map(&:id)).page(1)
    top_level_species = Fabricate.times 5, :species
    top_level_species.each do |species|
      Fabricate.times 2, :species, parent_id: species.id
    end
    @top_level_species = Species.top_level
    weapon_types = Fabricate.times 5, :weapon_type
    @weapon_types = WeaponType.all
  end

  it 'renders a list of no more than 10 locations' do
    render
    expect(rendered).to have_selector('.panel.location', count: 10)
  end

  it 'renders link to next page of locations' do
    render
    expect(rendered).to have_selector('a[rel="next"]')
  end

  it 'links to a search for the city/state' do
    render
    @locations.each do |location|
      expect(rendered).to have_link(location.city_state, href: locations_path(query: location.city_state))
    end
  end

  it 'has a linked title for each location' do
    render
    @locations.each do |location|
      expect(rendered).to have_link(location.name, href: location_path(location))
    end
  end

  it 'has a linked excerpt for each location' do
    render
    @locations.each do |location|
      expect(rendered).to have_link(location.excerpt, href: location_path(location))
    end
  end

  it 'has an input with average star rating for each location' do
    render
    @locations.each do |location|
      expect(rendered).to have_selector('input.rating', visible: false, text: location.average_star_rating)
    end
  end
end
