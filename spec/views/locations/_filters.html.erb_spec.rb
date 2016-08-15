require 'spec_helper'

RSpec.describe 'locations/_filters', type: :view do
  before(:each) do
    @query = 'Franklin, TN'
    categories = Fabricate.times 5, :category
    @categories = Category.all
    @category_id = categories[3].id
    top_level_species = Fabricate.times 5, :top_level_species
    top_level_species.each do |species|
      Fabricate.times 2, :species, parent_id: species.id
    end
    @top_level_species = Species.top_level
    weapon_types = Fabricate.times 5, :weapon_type
    @weapon_types = WeaponType.all
    @weapon_type_id = weapon_types[3].id

  end

  it 'renders location search form' do
    render
    expect(rendered).to have_selector('form')
    expect(rendered).to have_selector('input[type="hidden"][name="query"]', visible: false)
    expect(rendered).to have_select('category_id')
    expect(rendered).to have_selector('input[type="submit"]')
  end
  
  it 'hidden query field has current location in it' do
    render
    expect(rendered).to have_selector("input[type='hidden'][name='query'][value='#{@query}']", visible: false)
  end
  
  it 'renders options for each category' do
    render
    @categories.each do |category|
      expect(rendered).to have_selector('option', text: category)
    end
  end

  it 'pre-selects current search category' do
    render
    expect(rendered).to have_select('category_id', selected: Category.find(@category_id).name)
  end

  it 'renders options for each weapon type' do
    render
    @categories.each do |weapon_type|
      expect(rendered).to have_selector('option', text: weapon_type)
    end
  end

  it 'pre-selects current search weapon type' do
    render
    expect(rendered).to have_select('weapon_type_id', selected: WeaponType.find(@weapon_type_id).name)
  end
end