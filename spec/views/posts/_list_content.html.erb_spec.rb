require 'spec_helper'

RSpec.describe 'posts/_list_content', type: :view do
  let(:posts) do
    Fabricate.times 5, :post
    Post.all
  end
  before(:each) do
    assign(:posts, posts)
  end

  it 'renders a list of posts' do
    render
    expect(rendered).to have_selector('.post', count: posts.count)
  end

  it 'has a linked title for each post' do
    render
    posts.each do |post|
      expect(rendered).to have_link(post.title, href: post_path(post))
    end
  end
end
