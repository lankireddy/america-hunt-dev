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
  end
end