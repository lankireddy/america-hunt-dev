require 'spec_helper'

RSpec.describe 'posts/show', type: :view do
  include_context 'ad_page'
  before(:each) do
    @post = assign(:post, (Fabricate :post))
  end

  it 'displays sidebar ads' do
    render
    expect(rendered).to have_selector('.ad img')
  end

  it 'does not display a link to a category if it has no homepage-visible parent category' do
    render
    expect(rendered).to_not have_selector('a.priority-blog-category-link')
  end

  it 'displays a link to its parent category' do
    @post.blog_categories.first.update(homepage_display: 1)
    @post.reload
    render
    expect(rendered).to have_link("Click here for more #{@post.priority_blog_category.name}", href: blog_category_path(@post.priority_blog_category.friendly_id))
  end

  context 'with featured image' do
    it 'renders featured image as header background' do
      @post.update(featured_image: File.new("#{Rails.root}/spec/support/files/4.jpg"))
      render
      expect(view.content_for(:pre_main)).to have_selector("header[style='background-image: url(#{@post.featured_image.url(:hero)})']")
    end

    it 'renders title in h1' do
      render
      expect(view.content_for(:pre_main)).to have_selector('h1', text: @post.title)
    end

    it 'renders subtitle' do
      render
      expect(view.content_for(:pre_main)).to have_selector('.subtitle', text: @post.subtitle)
    end
  end

  context 'without featured image' do
    before(:each) do
      @post.featured_image = nil
      @post.save
    end
    it 'renders title in h1' do
      render
      expect(rendered).to have_selector('h1', text: @post.title)
    end
    it 'renders subtitle' do
      render
      expect(rendered).to have_selector('.subtitle', text: @post.subtitle)
    end
  end

  it 'renders page body in section' do
    render
    expect(rendered).to have_selector('section', text: @post.body)
  end
end
