require 'spec_helper'

describe 'Page' do
  let!(:admin_user) { Fabricate :admin_user }

  let!(:page_object) { Fabricate :page }

  before do
    login_admin admin_user
  end

  describe 'show' do
    it 'displays the featured image' do
      visit admin_page_path(page_object)
      expect(page).to have_selector('img.featured-image')
      expect(find('img.featured-image')['src']).to eq page_object.featured_image.url(:medium)
    end
  end

  describe 'new' do
    it 'had featured image upload field' do
      visit new_admin_page_path
      expect(page).to have_selector('#page_featured_image[type="file"]')
    end

    it 'saves the attached file' do
      visit new_admin_page_path

      fill_in('page[title]', with: 'File Upload Test')

      attach_file('page[featured_image]', File.absolute_path("#{Rails.root}/spec/support/files/4.jpg"))

      click_button('Create Page')

      expect(page).to have_selector('div.flash', text:'Page was successfully created.')
      new_page = Page.order(:created_at).last
      expect(new_page.featured_image.url).to include('4.jpg')
    end
  end
end