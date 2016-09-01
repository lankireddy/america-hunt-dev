require 'spec_helper'

RSpec.describe 'pages/show', type: :view do
  include_context 'ad_page'

  before(:each) do
    @page = assign(:page, (Fabricate :page))
  end

  it 'renders title in h1' do
    render
    expect(rendered).to have_selector('h1', text: @page.title)
  end

  it 'renders page body in section' do
    render
    expect(rendered).to have_selector('section', text: @page.body)
  end

  it 'renders nav' do
    render
    expect(view.content_for(:pre_main)).to have_selector('nav.pages-nav')
  end

  it 'renders image tag when featured image present' do
    render
    expect(rendered).to have_selector("img[src='#{@page.featured_image.url}']")
  end

  it 'renders newsletter form when enabled' do
    skip('No idea...')
    @page = Fabricate :page, display_newsletter_sign_up: true
    render
    expect(rendered).to have_selector('.page-newsletter-form')
  end
end
