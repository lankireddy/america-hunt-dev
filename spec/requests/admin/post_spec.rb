require 'spec_helper'

describe 'Post' do
  let!(:admin_user) { Fabricate :admin_user }

  let!(:post) { Fabricate :post }

  before do
    login_admin admin_user
  end

  describe 'show' do
    it 'displays the attached categories' do
      post.blog_categories.clear
      post.blog_categories << (Fabricate :blog_category)
      post.blog_categories << (Fabricate :blog_category)
      expect(post.blog_categories.count).to eq(2)
      visit admin_post_path(post)
      post.blog_categories.each do |blog_category|
        expect(page).to have_selector('li', text: blog_category.to_s)
      end
    end

    it 'displays the featured image' do
      visit admin_post_path(post)
      expect(page).to have_selector('img.featured-image')
      expect(find('img.featured-image')['src']).to eq post.featured_image.url(:medium)
    end
  end

  describe 'new' do
    it 'displays available categories as checkboxes' do
      Fabricate.times 5, :blog_category
      visit new_admin_post_path
      BlogCategory.all.each do |blog_category|
        expect(page).to have_field('post[blog_category_ids][]', with: blog_category.id)
      end
    end

    it 'has field for external link' do
      visit new_admin_post_path
      expect(page).to have_field('post[external_link]', type: 'url')
    end

    it 'had featured image upload field' do
      visit new_admin_post_path
      expect(page).to have_field('post[featured_image]', type: 'file')
    end

    it 'saves the attached file' do
      visit new_admin_post_path

      fill_in('post[title]', with: 'File Upload Test')

      attach_file('post[featured_image]', File.absolute_path("#{Rails.root}/spec/support/files/4.jpg"))

      click_button('Create Post')

      expect(page).to have_selector('div.flash', text: 'Post was successfully created.')
      new_post = Post.order(:created_at).last
      expect(new_post.featured_image.url).to include('4.jpg')
    end

    it 'can add an image to the post body', js: true do
      file = File.new("#{Rails.root}/spec/support/files/test.png")
      visit new_admin_post_path
      fill_in('post[title]', with: 'File Upload Test')
      attach_file('post[featured_image]', File.absolute_path("#{Rails.root}/spec/support/files/4.jpg"))

      expect(page).to have_selector('a.cke_button__image')
      page.execute_script %{ $('a[title="Source"]').trigger('click') }
      page.execute_script %{ $('textarea.cke_source').val('<h1>Test Post</h1><img alt="" src="#{file.path}" style="width: 165px; height: 189px;" />') }

      click_button('Create Post')

      expect(page).to have_selector('div.flash', text: 'Post was successfully created.')
      new_post = Post.order(:created_at).last
      visit post_path(new_post)

      expect(page).to have_content('Test Post')
      expect(page).to have_selector("img[src='#{file.path}']")
    end
  end
end
