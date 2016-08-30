require 'spec_helper'

RSpec.describe 'layouts/application', type: :view do
  include_context 'ad_page'

  before(:each) do
    @location = Fabricate :location
    @page_title = 'America Hunt: ' + @location.name
    @page_description = @location.excerpt
  end

  it 'has metas for title and description' do
    render
    expect(rendered).to have_selector('title', text: @page_title, visible: false)
    expect(rendered).to have_selector("meta[name='description'][content='#{@location.excerpt}']", visible: false)
  end

  it 'displays top ad' do
    render
    expect(rendered).to have_selector('img.header-ad')
  end
end