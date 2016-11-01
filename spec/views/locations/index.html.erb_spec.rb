require 'spec_helper'

RSpec.describe 'locations/index', type: :view do
  include_context 'ad_page'

  let(:locations) { Fabricate.times 15, :location, state: 'ID' }
  let(:categories) { Fabricate.times 5, :category }
  let(:top_level_species) { Fabricate.times 5, :species }

  before(:each) do
    controller.request.path = state_locations_path(state_alpha2: 'ID')
    @categories = Category.where(id: categories.map(&:id))
    @locations = Kaminari.paginate_array(locations).page(1).per(10)
    top_level_species.each do |species|
      Fabricate.times 2, :species, parent_id: species.id
    end
    @top_level_species = Species.top_level
    @title = 'Title for this directory page'
    @location_params = { state_alpha2: 'ID' }
  end

  it 'renders h1 for with @title' do
    render
    expect(rendered).to have_selector('h1', text: @title)
  end

  it 'renders a list of no more than 10 locations' do
    render
    expect(rendered).to have_selector('.panel.location', count: 10)
  end

  it 'renders link to next page of locations' do
    render
    expect(rendered).to have_selector('a[rel="next"]')
  end

  it 'links to a search for the state on each location' do
    render
    @locations.each do |location|
      expect(rendered).to have_link(location.city_state, href: state_locations_path(state_alpha2: location.state))
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
