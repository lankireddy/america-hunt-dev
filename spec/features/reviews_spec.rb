require 'spec_helper'

describe 'Reviews', type: :feature do

  describe 'review form' do
    let(:location) { Fabricate :location }
    let(:empty_star_selector) { '.rating-container .empty-stars .star' }

    describe 'as logged in user' do
      let!(:user) { Fabricate :user}

      before do
        login user
      end
      it 'replaces star rating input with bootstrap star control', js: true do
        visit location_path(location)
        expect(page).to have_selector('.rating-container')
      end

      it 'shows 5 empty stars on first visit', js: true do
        visit location_path(location)
        expect(page).to have_selector(empty_star_selector, count: 5)
      end

      it 'clicking on a star sets the rating', js: true do
        visit location_path(location)
        expect(page).to have_selector(empty_star_selector, count: 5)
        all(empty_star_selector).last.trigger(:click)
        expect(page).to have_selector('#review_star_rating', visible: false)
      end

      it 'sends review via ajax', js: true do
        visit location_path(location)
        expect do
          fill_in 'review_body', with: 'Message text'
          click_button 'Finish'
          expect(page).to have_content 'Message text'
        end.to change(Review, :count).by 1
      end

      it 'displays errors on the page from ajax submit', js: true do
        visit location_path(location)
        expect do
          click_button 'Finish'
          expect(page).to have_content "can't be blank"
        end.to_not change(Review, :count)
      end
    end
  end
end