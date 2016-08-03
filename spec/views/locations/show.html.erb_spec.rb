require 'spec_helper'

RSpec.describe 'locations/show', type: :view do
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
end
