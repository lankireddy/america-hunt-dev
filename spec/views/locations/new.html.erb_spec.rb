require 'spec_helper'

RSpec.describe 'locations/new', type: :view do
  include_context 'ad_page'

  let!(:user) { Fabricate :user}

  context 'as signed in user' do
    let!(:top_level_species) do
      top_level_species = Fabricate.times 5, :species
      top_level_species.each do |species|
        Fabricate.times 2, :species, parent_id: species.id
      end
      top_level_species
    end
    before(:each) do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(user)
      allow(view).to receive(:policy).and_return(double('some policy', new?: true))
      assign(:location, (Fabricate.build :location))
      categories = Fabricate.times 5, :category
      @categories = Category.where(id: categories.map(&:id))
      @top_level_species = Species.top_level
      weapon_types = Fabricate.times 5, :weapon_type
      @weapon_types = WeaponType.all
    end

    it 'renders new location form' do
      render

      assert_select 'form[action=?][method=?]', locations_path, 'post' do

        assert_select 'input#location_name[name=?]', 'location[name]'

        assert_select 'input#location_website[name=?]', 'location[website]'

        assert_select 'input#location_phone[name=?]', 'location[phone]'

        assert_select 'input#location_email[name=?]', 'location[email]'

        assert_select 'input#location_address_1[name=?]', 'location[address_1]'

        assert_select 'input#location_address_2[name=?]', 'location[address_2]'

        assert_select 'input#location_city[name=?]', 'location[city]'

        assert_select 'input#location_state[name=?]', 'location[state]'

        assert_select 'input#location_zip[name=?]', 'location[zip]'

        assert_select 'input#location_handicap_status_handicap_accessible[name=?]', 'location[handicap_status]'

        assert_select 'input#location_handicap_status_handicap_na[name=?]', 'location[handicap_status]'

        assert_select 'input#location_featured_image[name=?]', 'location[featured_image]'

        assert_select 'input#location_hunting_area_size[name=?]', 'location[hunting_area_size]'

        assert_select 'textarea#location_terrain[name=?]', 'location[terrain]'

        assert_select 'textarea#location_submitter_notes[name=?]', 'location[submitter_notes]'
      end
    end
  end

  context 'as anonymous user' do
    before(:each) do
      allow(view).to receive(:user_signed_in?).and_return(false)
    end

    it 'displays links to login or sign in' do
      render
      assert_select 'p' do
        expect(rendered).to have_link(I18n.t('navigation.links.login'))
        expect(rendered).to have_link(I18n.t('navigation.links.register'), href: new_user_registration_path)
      end
    end
  end
end
