require 'spec_helper'

describe 'HomepageVideo' do
  let!(:admin_user) { Fabricate :admin_user }

  let!(:homepage_video) { Fabricate :homepage_video }

  before do
    login_admin admin_user
  end

  describe 'show' do
    it 'displays the video' do
      visit admin_homepage_video_path(homepage_video)
      expect(page).to have_selector('video')
      expect(find('video')['src']).to eq homepage_video.video.url
    end
  end

  describe 'new' do
    it 'had featured image upload field' do
      visit new_admin_homepage_video_path
      expect(page).to have_field('homepage_video[video]', type: 'file')
    end

    it 'saves the attached file' do
      visit new_admin_homepage_video_path

      fill_in('homepage_video[name]', with: 'File Upload Test')

      attach_file('homepage_video[video]', File.absolute_path("#{Rails.root}/spec/support/files/30 Second Countdown Timer.mp4"))

      click_button('Create Homepage video')

      expect(page).to have_selector('div.flash', text: 'Homepage video was successfully created.')
      new_homepage_video = HomepageVideo.order(:created_at).last
      expect(new_homepage_video.video.url).to include('30_Second')
    end
  end
end