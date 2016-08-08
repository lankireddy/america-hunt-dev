require 'spec_helper'

RSpec.describe 'posts/_list', type: :view do
  let(:content_posts) { Fabricate.times 2, :content_post }
  before(:each) do
    assign(:content_posts, content_posts)
  end

  it 'renders a list of posts' do
    render
    expect(rendered).to have_selector('.panel.post', count: content_posts.count)
  end

  it 'has a linked title for each post' do
    render
    content_posts.each do |post|
      expect(rendered).to have_link(post.title, href: post_path(post))
    end
  end

  it 'has a linked post date for each post' do
    render
    content_posts.each do |post|
      expect(rendered).to have_link(post.created_at.strftime('%A, %B %-d, %Y'), href: post_path(post))
    end
  end
end