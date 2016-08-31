require 'spec_helper'

describe 'Species' do
  let!(:admin_user) { Fabricate :admin_user }

  let!(:species) { Fabricate :species}

  before do
    login_admin admin_user
  end

  describe 'new' do
    it 'displays available parents as select options' do
      Fabricate.times 5, :species
      visit new_admin_species_path
      Species.top_level.each do |species|
        expect(page).to have_selector('option', text: species.name)
      end
    end
  end
end