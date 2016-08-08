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
  end

  describe 'new' do
    it 'displays available categories as checkboxes' do
      Fabricate.times 5, :category
      visit new_admin_location_path
      Category.all.each do |category|
        expect(page).to have_field('location[category_ids][]',with: category.id)
      end
    end
  end
end