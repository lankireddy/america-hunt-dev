require 'spec_helper'

RSpec.describe 'home_page/_location_search', type: :view do
  before(:each) do
    @categories = Fabricate.times 5, :category
    @species = Fabricate.times 5, :species
    @content_posts = []
  end

  it 'renders location search form' do
    render
    expect(rendered).to have_selector('form')
    expect(rendered).to have_field('query')
    expect(rendered).to have_select('category_id')
    expect(rendered).to have_selector('input[type="submit"]')
  end

  it 'renders options for each category' do
    render
    @categories.each do |category|
      expect(rendered).to have_selector('option', text: category)
    end
  end
end