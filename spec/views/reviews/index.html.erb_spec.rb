require 'spec_helper'

RSpec.describe 'reviews/index', type: :view do
  include_context 'ad_page'
  let!(:location) { Fabricate :location}
  let!(:reviews) { Fabricate.times 15, :review, location: location }
  before(:each) do
    @location = location
    @reviews = location.reviews.page 1
  end

  it 'renders a list of 10 reviews' do
    render
    expect(rendered).to have_selector('.review', count: 10)
  end

  it 'renders link to next page of reviews' do
    render
    expect(rendered).to have_selector('a[rel="next"]')
  end
end
