require 'spec_helper'

describe 'Review' do
  let!(:admin_user) { Fabricate :admin_user }

  let!(:review) { Fabricate :review }

  before do
    login_admin admin_user
  end

  describe 'edit' do
    it 'displays statuses dropdown' do
      visit edit_admin_review_path(review.id)
      expect(page).to have_select('review[status]')
    end
  end
end
