require 'spec_helper'

describe 'User' do
  let!(:admin_user) { Fabricate :admin_user }

  let!(:user) { Fabricate :user }

  before do
    login_admin admin_user
  end

  describe 'show' do
    it 'displays the featured image' do
      visit admin_user_path(user)
      expect(page).to have_selector('img.profile-image')
      expect(find('img.profile-image')['src']).to eq user.profile_image.url(:small)
    end
  end

end