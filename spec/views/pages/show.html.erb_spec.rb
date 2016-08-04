require 'spec_helper'

RSpec.describe 'pages/show', type: :view do
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
end
