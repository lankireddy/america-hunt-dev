require 'spec_helper'

RSpec.describe 'posts/_list_content', type: :view do
  let(:posts) do
    Fabricate.times 5, :content_post
    Post.all
  end
  before(:each) do
    assign(:posts, posts)
  end

  it 'renders the most recent post first' do
    render
    expect(posts.maximum(:created_at)).to eq(posts.first.created_at)
    expect(posts[0].created_at).to_not eq(posts[4].created_at)
  end

  it 'renders a list of posts' do
    render
    expect(rendered).to have_selector('.panel.post', count: posts.count)
  end

  it 'has a linked title for each post' do
    render
    posts.each do |post|
      expect(rendered).to have_link(post.title, href: post_path(post))
    end
  end
end
