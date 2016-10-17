require 'spec_helper'

RSpec.describe 'posts/index', type: :view do
  include_context 'ad_page'

  let!(:posts) { Fabricate.times 15, :content_post }

  before(:each) do
    @posts = Post.all.page(1)
    @menu_categories = Fabricate.times 3, :blog_category, homepage_display: 'name_only'
  end

  it 'renders links to categories' do
    render
    menu_area = view.content_for(:pre_main)
    @menu_categories.each do |category|
      expect(menu_area).to have_link(category.name, href: blog_category_path(category))
    end
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
