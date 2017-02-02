require 'spec_helper'

RSpec.describe 'layouts/application', type: :view do
  include_context 'ad_page'

  before(:each) do
    @location = Fabricate :location
    @page_title = 'America Hunt: ' + @location.name
    @page_description = @location.excerpt
    render
  end

  it 'has metas for title and description' do
    expect(rendered).to have_selector('title', text: @page_title, visible: false)
    expect(rendered).to have_selector("meta[name='description'][content='#{@location.excerpt}']", visible: false)
  end

  it 'displays top ad' do
    pending('this needs to be redone')
    expect(rendered).to have_selector('.ad-header img')
  end

  it 'displays the standard nav bar' do
    expect(rendered).to have_selector('nav.navbar-inverse')
  end

  it 'has a link for each blog category page' do
    BlogCategory.all.each do |blog_category|
      expect(rendered).to have_selector("a[href='#{blog_category_path(blog_category)}']")
    end
  end

  it 'has a link for each page' do
    expect(rendered).to have_selector("a[href='#{page_path('about')}']")
    expect(rendered).to have_selector("a[href='#{page_path('press-&amp;-media')}']")
    expect(rendered).to have_selector("a[href='#{page_path('faq')}']")
    expect(rendered).to have_selector("a[href='#{page_path('terms-of-service')}']")
    expect(rendered).to have_selector("a[href='#{page_path('privacy-policy')}']")
  end
end
