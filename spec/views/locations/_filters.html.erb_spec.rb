require 'spec_helper'

RSpec.describe 'locations/_filters', type: :view do
  before(:each) do
    @query = 'Franklin, TN'
    categories = Fabricate.times 5, :category
    @categories = Category.where(id: categories.map(&:id))
    @category_id = categories[3].id
    top_level_species = Fabricate.times 5, :top_level_species
    top_level_species.each do |species|
      Fabricate.times 2, :species, parent_id: species.id
    end
    @top_level_species = Species.top_level
  end

  it 'renders location search form' do
    render
    expect(rendered).to have_selector('form')
    expect(rendered).to have_selector('input[type="hidden"][name="query"]', visible: false)
    expect(rendered).to have_select('category_id')
    expect(rendered).to have_selector('input[type="submit"]')
  end

  it 'renders options for each category' do
    render
    @categories.each do |category|
      expect(rendered).to have_selector('option', text: category)
    end
  end

  it 'hidden query field has current location in it' do
    render
    expect(rendered).to have_selector("input[type='hidden'][name='query'][value='#{@query}']", visible: false)
  end

  it 'pre-selects current search category' do
    render
    expect(rendered).to have_select('category_id', selected: Category.find(@category_id).name)
  end
end