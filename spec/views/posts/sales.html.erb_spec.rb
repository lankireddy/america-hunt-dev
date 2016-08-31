require 'spec_helper'

RSpec.describe 'posts/sales', type: :view do
  include_context 'ad_page'
  let!(:link_posts) { Fabricate.times 15, :link_post }
  before(:each) do
    @link_posts = Post.link_posts.page(1)
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
