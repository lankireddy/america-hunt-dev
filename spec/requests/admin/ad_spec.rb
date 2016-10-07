require 'spec_helper'

describe 'Ad' do
  let!(:admin_user) { Fabricate :admin_user }

  let!(:ad) { Fabricate :ad }

  before do
    login_admin admin_user
  end

  describe 'show' do
    it 'displays the featured image', js: true do
      visit admin_ad_path(ad)
      expect(page).to have_selector('img.image')
      expect(find('img.image')['src']).to eq ad.image.url(:medium)
    end
  end

  describe 'new' do
    it 'had featured image upload field' do
      visit new_admin_ad_path
      expect(page).to have_field('ad[image]', type: 'file')
    end

    it 'saves the attached file' do
      visit new_admin_ad_path

      fill_in('ad[name]', with: 'File Upload Test')

      fill_in('ad[url]', with: Faker::Internet.url)

      attach_file('ad[image]', File.absolute_path("#{Rails.root}/spec/support/files/4.jpg"))

      click_button('Create Ad')

      expect(page).to have_selector('div.flash', text: 'Ad was successfully created.')
      new_ad = Ad.order(:created_at).last
      expect(new_ad.image.url).to include('4.jpg')
    end
  end
end
