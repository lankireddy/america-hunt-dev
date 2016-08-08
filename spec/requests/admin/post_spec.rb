require 'spec_helper'

describe 'Post' do
  let!(:admin_user) { Fabricate :admin_user }

  let!(:post) { Fabricate :post }

  before do
    login_admin admin_user
  end

  describe 'show' do
    it 'displays the attached categories' do
      post.blog_categories << (Fabricate :blog_category)
      post.blog_categories << (Fabricate :blog_category)
      expect(post.blog_categories.count).to eq(2)
      visit admin_post_path(post)
      post.blog_categories.each do |blog_category|
        expect(page).to have_selector('li',text:blog_category.to_s)
      end
    end
  end

  describe 'new' do
    it 'displays available categories as checkboxes' do
      Fabricate.times 5, :blog_category
      visit new_admin_post_path
      BlogCategory.all.each do |blog_category|
        expect(page).to have_field('post[blog_category_ids][]',with: blog_category.id)
      end
    end
  end
end