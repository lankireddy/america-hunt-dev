require 'spec_helper'

RSpec.describe 'posts/show', type: :view do
  include_context 'ad_page'
  before(:each) do
    @post = assign(:post, (Fabricate :post))
  end

  it 'displays sidebar ads' do
    render
    expect(rendered).to have_selector('img.ad')
  end

  context 'with featured image' do
    it 'renders featured image as header background' do
      render
      expect(view.content_for(:pre_main)).to have_selector("header[style='background-image: url(#{@post.featured_image.url(:hero) })']")
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
