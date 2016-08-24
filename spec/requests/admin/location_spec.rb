require 'spec_helper'

describe 'Location' do
  let!(:admin_user) { Fabricate :admin_user }

  let!(:location) { Fabricate :location }

  before do
    login_admin admin_user
  end

  describe 'show' do
    it 'displays the featured image' do
      visit admin_location_path(location)
      expect(page).to have_selector('img.featured-image')
      expect(find('img.featured-image')['src']).to eq location.featured_image.url(:medium)
    end

    it 'displays the attached categories' do
      location.categories << (Fabricate :category)
      location.categories << (Fabricate :category)
      expect(location.categories.count).to eq(2)
      visit admin_location_path(location)
      location.categories.each do |category|
        expect(page).to have_selector('li',text:category.to_s)
      end
    end

    it 'displays the attached species' do
      parent = Fabricate :top_level_species
      location.species << (Fabricate :species, parent_id: parent.id)
      location.species << (Fabricate :species, parent_id: parent.id)
      expect(location.species.count).to eq(2)
      visit admin_location_path(location)
      location.species.each do |species|
        expect(page).to have_selector('li',text:species.to_s)
      end
    end

    it 'displays the attached weapon types' do
      location.weapon_types << (Fabricate :weapon_type)
      location.weapon_types << (Fabricate :weapon_type)
      expect(location.weapon_types.count).to eq(2)
      visit admin_location_path(location)
      location.weapon_types.each do |weapon_type|
        expect(page).to have_selector('li',text:weapon_type.to_s)
      end
    end
  end

  describe 'new' do
    it 'displays statuses dropdown' do
      visit new_admin_location_path
      expect(page).to have_select('location[status]')
    end
    it 'displays available categories as checkboxes' do
      Fabricate.times 5, :category
      visit new_admin_location_path
      Category.all.each do |category|
        expect(page).to have_field('location[category_ids][]',with: category.id)
      end
    end

    it 'displays available weapon types as checkboxes' do
      Fabricate.times 5, :weapon_type
      visit new_admin_location_path
      Category.all.each do |weapon_type|
        expect(page).to have_field('location[weapon_type_ids][]',with: weapon_type.id)
      end
    end

    it 'displays specific species as checkboxes' do
      parent = Fabricate :species, name: 'Pokemon'
      Fabricate.times 5, :species, parent_id: parent.id
      visit new_admin_location_path
      Species.specific.each do |species|
        expect(page).to have_field('location[species_ids][]',with: species.id)
      end
    end

    it 'had featured image upload field' do
      visit new_admin_location_path
      expect(page).to have_selector('#location_featured_image[type="file"]')
    end

    it 'saves the attached file' do
      visit new_admin_location_path

      fill_in('location[name]', with: 'File Upload Test')

      attach_file('location[featured_image]', File.absolute_path("#{Rails.root}/spec/support/files/4.jpg"))

      click_button('Create Location')

      expect(page).to have_selector('div.flash', text:'Location was successfully created.')
      new_location = Location.order(:created_at).last
      expect(new_location.featured_image.url).to include('4.jpg')
    end
  end
end