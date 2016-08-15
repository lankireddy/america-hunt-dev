require 'spec_helper'

describe 'Location' do
  let!(:admin_user) { Fabricate :admin_user }

  let!(:location) { Fabricate :location }

  before do
    login_admin admin_user
  end

  describe 'show' do
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
    it 'displays available categories as checkboxes' do
      Fabricate.times 5, :category
      visit new_admin_location_path
      Category.all.each do |category|
        expect(page).to have_field('location[category_ids][]',with: category.id)
      end
    end

    it 'displays available categories as checkboxes' do
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
  end
end