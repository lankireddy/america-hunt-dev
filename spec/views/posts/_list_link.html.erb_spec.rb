require 'spec_helper'

RSpec.describe 'posts/_list_link', type: :view do
  let(:link_posts) do
    Fabricate.times 5, :link_post
    Post.link_posts
  end
  before(:each) do
    assign(:link_posts, link_posts)
  end

  it 'renders the most recent post first' do
    expect(link_posts.count).to eq 5
    render
    expect(link_posts.maximum(:created_at)).to eq(link_posts.first.created_at)
    expect(link_posts[0].created_at).to_not eq(link_posts[4].created_at)
  end
  it 'renders a list of posts' do
    render
    expect(rendered).to have_selector('#hunting-sales li', count: link_posts.count)
  end

  it 'has a linked title for each post' do
    render
    link_posts.each do |post|
      expect(rendered).to have_link(post.title, href: post.external_link)
    end
  end
end