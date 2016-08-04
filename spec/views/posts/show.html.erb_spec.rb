require 'spec_helper'

RSpec.describe 'posts/show', type: :view do
  before(:each) do
    @post = assign(:post, (Fabricate :post))
  end

  it 'renders title in h1' do
    render
    expect(rendered).to have_selector('h1', text: @post.title)
  end

  it 'renders subtitle in ' do
    render
    expect(rendered).to have_selector('p', text: @post.subtitle)
  end

  it 'renders page body in section' do
    render
    expect(rendered).to have_selector('section', text: @post.body)
  end
end
