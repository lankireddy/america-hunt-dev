require 'spec_helper'

RSpec.describe 'locations/show', type: :view do
  let!(:user) { Fabricate :user}

  before(:each) do

    @location = Fabricate :location
    @previous_page = '/locations?query=Portland,TX'
    @page_title = 'America Hunt: ' + @location.name
    @page_description = @location.excerpt
  end

  it 'displays name in title' do
    render
    expect(rendered).to have_selector('h1',text:@location.name)
  end

  it 'displays description' do
    render
    expect(rendered).to include @location.description
  end

  it 'has link back to search page' do
    render
    expect(rendered).to have_link('Back to search results', href: @previous_page)
  end

  it 'displays all reviews' do
    Fabricate.times 5, :review, location: @location
    render
    expect(rendered).to have_selector('article.review', count: 5)
  end

  it 'has a link to the review form anchor' do
    render
    expect(rendered).to have_link('Write a Review')
  end

  it 'has review form as logged in user' do
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(user)
    allow(view).to receive(:policy).and_return(double('some policy', new?: true))
    render
    assert_select 'form[action=?][method=?]', location_reviews_path(@location), 'post'
  end
end
