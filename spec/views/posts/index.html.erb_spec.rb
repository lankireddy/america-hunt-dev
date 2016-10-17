require 'spec_helper'

RSpec.describe 'posts/index', type: :view do
  include_context 'ad_page'
  let!(:posts) { Fabricate.times 15, :content_post }
  before(:each) do
    @posts = Post.all.page(1)
  end

  it 'renders a list of 10 posts' do
    render
    expect(rendered).to have_selector('.post', count: 10)
  end

  it 'renders link to next page of posts' do
    render
    expect(rendered).to have_selector('a[rel="next"]')
  end
end
