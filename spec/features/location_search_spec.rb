require 'spec_helper'

describe 'Location Search', type: :feature do

  describe 'species multi-select' do
    let!(:top_level_species) { Fabricate.times 5, :species }

    it 'displays a button in place of the species select', js: true do
      visit root_path
      expect(page).to have_selector('.multiselect-native-select .btn-group')
    end

    it 'displays a list of options when clicked', js: true do
      visit root_path
      expect(page).to have_selector('.multiselect-native-select .btn-group')
      click_button('What?')
      expect(page).to have_selector('.multiselect-native-select ul.dropdown-menu')
    end

    it 'displays an option for each top level species ', js: true do
      visit root_path
      expect(page).to have_selector('.multiselect-native-select .btn-group')
      click_button('What?')
      within(:css, '.multiselect-native-select ul.dropdown-menu') do
        top_level_species.each do |species|
          expect(page).to have_selector('label', text: species.name)
        end
      end
    end
    
    it 'species ids are posted on form submit', js: true do
      visit root_path
      fill_in 'query', with: 'Franklin, TN'
      expect(page).to have_selector('.multiselect-native-select .btn-group')
      click_button('What?')
      within(:css, '.multiselect-native-select ul.dropdown-menu') do
        top_level_species.each do |species|
          expect(page).to have_selector('label', text: species.name)
        end
        check top_level_species[0].name
      end
      #using trigger instead of button_click because
      # capybara is incorrect about the button being hidden
      page.find('.btn-search').trigger('click')

      expect(CGI::parse(URI.parse(current_url).query)['top_level_species_ids[]']).to eq([top_level_species[0].id.to_s])
    end
  end
end