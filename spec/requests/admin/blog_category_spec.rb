require 'spec_helper'

describe 'BlogCategory' do
  let!(:admin_user) { Fabricate :admin_user }

  let!(:blog_category) { Fabricate :blog_category }

  before do
    login_admin admin_user
  end

  describe 'new' do
    it 'displays display_homepage dropdown' do
      visit new_admin_blog_category_path
      expect(page).to have_select('blog_category[homepage_display]')
    end
  end
end
