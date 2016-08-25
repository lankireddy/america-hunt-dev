require 'spec_helper'

RSpec.describe 'posts/show', type: :view do
  before(:each) do
    @post = assign(:post, (Fabricate :post))
  end

  context 'with featured image' do
    it 'renders featured image as header background' do
      render
      expect(view.content_for(:pre_main)).to have_selector("header[style='background-image: url(#{@post.featured_image.url(:hero)})']")
    end

    it 'renders title in h1' do
      render
      expect(view.content_for(:pre_main)).to have_selector('h1', text: @post.title)
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
  end
  it 'renders subtitle in p' do
    render
    expect(rendered).to have_selector('p', text: @post.subtitle)
  end

  it 'renders page body in section' do
    render
    expect(rendered).to have_selector('section', text: @post.body)
  end
end
