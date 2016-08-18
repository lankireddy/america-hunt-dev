require 'spec_helper'

describe 'Location Filter', type: :feature do

  describe 'species multi-select' do
    let!(:top_level_species) { Fabricate.times 5, :top_level_species }

    before do
      top_level_species.each do |top_level_species|
        Fabricate.times 2, :species, parent_id: top_level_species.id
      end
    end

    it 'displays a button in place of the species select', js: true do
      visit locations_path
      expect(page).to have_selector('.multiselect-native-select .btn-group')
    end

    it 'displays a list of options when clicked', js: true do
      visit locations_path
      expect(page).to have_selector('.multiselect-native-select .btn-group')
      click_button('What?')
      expect(page).to have_selector('.multiselect-native-select ul.dropdown-menu')
    end

    it 'displays an option group for each top level species ', js: true do
      visit locations_path
      expect(page).to have_selector('.multiselect-native-select .btn-group')
      click_button('What?')
      within(:css, '.multiselect-native-select ul.dropdown-menu') do
        top_level_species.each do |species|
          expect(page).to have_selector('.multiselect-group', text: species.name)
        end
      end
    end

    it 'displays an option for each specific species ', js: true do
      visit locations_path
      expect(page).to have_selector('.multiselect-native-select .btn-group')
      click_button('What?')
      within(:css, '.multiselect-native-select ul.dropdown-menu') do
        page.all('.caret-container').each { |caret| caret.click() }
        Species.specific.each do |species|
          expect(page).to have_selector('label', text: species.name)
        end
      end
    end

    it 'species ids are posted on form submit', js: true do
      first_species = top_level_species[0].children.first
      visit locations_path
      fill_in 'query', with: 'Franklin, TN'
      expect(page).to have_selector('.multiselect-native-select .btn-group')
      click_button('What?')
      within(:css, '.multiselect-native-select ul.dropdown-menu') do
        first('.caret-container').click()
        check first_species.name
      end
      #using trigger instead of button_click because
      # capybara is incorrect about the button being hidden
      find('.btn-search').trigger('click')

      expect(CGI::parse(URI.parse(current_url).query)['species_ids[]']).to eq([first_species.id.to_s])
    end
  end
end