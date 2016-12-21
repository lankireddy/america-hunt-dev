require 'spec_helper'

def fill_address_fields
  select('Alaska', from: 'location[state]')
  fill_in('location[city]', with: 'Fairbanks')
  fill_in('location[zip]', with: '00000')
end

describe 'Location Form', type: :feature do

  describe 'only displays the form for logged in users' do
    it 'doesn\'t show the form to non-logged visitors' do
      visit new_location_path
      expect(page).to_not have_selector('form[action="/locations"][method="post"]')
    end
    it 'shows the form to logged in users' do
      login Fabricate :user
      visit new_location_path
      expect(page).to have_selector('form[action="/locations"][method="post"]')
    end
  end

  describe 'as logged in user' do
    before do
      login Fabricate :user
    end
    describe 'species multi-select' do
      let!(:button_text) { 'No Species' }
      let!(:top_level_species) { Fabricate.times 5, :top_level_species }

      before do
        top_level_species.each do |top_level_species|
          Fabricate.times 2, :species, parent_id: top_level_species.id
        end
      end

      it 'displays a button in place of the species select', js: true do
        visit new_location_path
        expect(page).to have_selector(".multiselect-native-select button.multiselect[title='#{button_text}']")
      end

      describe 'with clicked button' do
        before do
          visit new_location_path
          expect(page).to have_selector('.multiselect-native-select .btn-group')
          click_button(button_text)
        end

        it 'displays a list of options when clicked', js: true do
          expect(page).to have_selector('.multiselect-native-select ul.dropdown-menu')
        end

        it 'displays an option group for each top level species ', js: true do
          within(:css, '.multiselect-native-select ul.dropdown-menu') do
            top_level_species.each do |species|
              expect(page).to have_selector('.multiselect-group', text: species.name)
            end
          end
        end

        it 'displays an option for each specific species ', js: true do
          skip 'webkit issues'
          within(:css, '.multiselect-native-select ul.dropdown-menu') do
            page.all('.caret-container').each { |caret| caret.click }
            Species.specific.each do |species|
              expect(page).to have_selector('label', text: species.name)
            end
          end
        end
      end

      it 'saves species ids on new location', js: true do
        skip 'webkit issues'
        first_species = top_level_species[0].children.first
        visit new_location_path
        fill_in('location[name]', with: 'Species Test')
        expect(page).to have_selector('.multiselect-native-select .btn-group')
        click_button(button_text)
        within(:css, '.multiselect-native-select ul.dropdown-menu') do
          first('.caret-container').click
          check first_species.name
        end

        find('.btn-save').trigger('click')
        expect(page).to have_selector('h2', text: 'Thank you for submitting a destination')
        new_location = Location.order(:created_at).last
        expect(new_location.name).to eq('Species Test')
        expect(new_location.species_ids).to include(first_species.id)
      end
    end

    describe 'category multiselect' do
      let!(:categories) { Fabricate.times 5, :category }
      let!(:button_text) { 'No Categories' }


      it 'displays a button in place of the category select', js: true do
        visit new_location_path
        expect(page).to have_selector(".multiselect-native-select button.multiselect[title='#{button_text}']")
      end

      describe 'with clicked button' do
        before do
          visit new_location_path
          expect(page).to have_selector(".multiselect-native-select button.multiselect[title='#{button_text}']")
          click_button(button_text)
        end
        it 'displays a list of options when clicked', js: true do
          expect(page).to have_selector('.multiselect-native-select ul.dropdown-menu')
        end
        it 'displays an option for each category ', js: true do
          within(:css, '.multiselect-native-select ul.dropdown-menu') do
            Category.all.each do |category|
              expect(page).to have_selector('label', text: category.to_s)
            end
          end
        end
      end

      it 'saves category ids on new location', js: true do
        new_location_name = 'Category Test'
        first_category = categories[0]
        visit new_location_path
        fill_in('location[name]', with: new_location_name)
        fill_address_fields
        expect(page).to have_selector('.multiselect-native-select .btn-group')
        click_button(button_text)
        check first_category.name
        find('.btn-save').trigger('click')
        expect(page).to have_selector('h2', text: 'Thank you for submitting a destination')
        new_location = Location.order(:created_at).last
        expect(new_location.name).to eq(new_location_name)
        expect(new_location.category_ids).to include(first_category.id)
      end
    end

    describe 'weapon type multiselect' do
      let!(:weapon_types) { Fabricate.times 5, :weapon_type }
      let!(:button_text) { 'No Weapon Types' }


      it 'displays a button in place of the weapon_type select', js: true do
        visit new_location_path
        expect(page).to have_selector(".multiselect-native-select button.multiselect[title='#{button_text}']")
      end

      describe 'with clicked button' do
        before do
          visit new_location_path
          expect(page).to have_selector(".multiselect-native-select button.multiselect[title='#{button_text}']")
          click_button(button_text)
        end

        it 'displays a list of options when clicked', js: true do
          expect(page).to have_selector('.multiselect-native-select ul.dropdown-menu')
        end

        it 'displays an option for each weapon_type ', js: true do
          within(:css, '.multiselect-native-select ul.dropdown-menu') do
            WeaponType.all.each do |weapon_type|
              expect(page).to have_selector('label', text: weapon_type.to_s)
            end
          end
        end
      end

      it 'saves weapon_type ids on new location', js: true do
        Rails.logger.info("1")
        new_location_name = 'Category Test'
        first_weapon_type = weapon_types[0]
        visit new_location_path
        fill_in('location[name]', with: new_location_name)
        fill_address_fields
        Rails.logger.info("2")
        expect(page).to have_selector('.multiselect-native-select .btn-group')
        click_button(button_text)
        check first_weapon_type.name
        find('.btn-save').trigger('click')
        expect(page).to have_selector('h2', text: 'Thank you for submitting a destination')
        new_location = Location.order(:created_at).last
        expect(new_location.name).to eq(new_location_name)
        expect(new_location.weapon_type_ids).to include(first_weapon_type.id)
      end
    end

    describe 'featured image upload' do
      it 'saves the attached file' do
        visit new_location_path

        fill_in('location[name]', with: 'File Upload Test')
        fill_address_fields

        attach_file('location[featured_image]', File.absolute_path("#{Rails.root}/spec/support/files/4.jpg"))

        find('.btn-save').click

        expect(page).to have_selector('h2', text: 'Thank you for submitting a destination')
        new_location = Location.order(:created_at).last
        expect(new_location.featured_image.url).to include('4.jpg')
      end
    end
  end
end
