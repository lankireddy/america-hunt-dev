require 'spec_helper'

describe 'Reviews', type: :feature do
  let(:location) { Fabricate :location }

  describe 'location header' do
    it 'renders stars for average rating', js: true do
      Fabricate :review, location: location, status: 'approved'
      visit location_path(location)
      expect(page).to have_selector('header .filled-stars .star')
    end
  end

  describe 'review listing' do
    it 'renders stars for ratings', js: true do
      Fabricate :review, location: location, status: 'approved'
      visit location_path(location)
      expect(page).to have_selector('.review .filled-stars .star')
    end
  end

  describe 'review form' do

    let(:empty_star_selector) { '#new_review .rating-container .empty-stars .star' }

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
        skip('Need a way to click the stars')
        visit location_path(location)
        expect(page).to have_selector(empty_star_selector, count: 5)
        page.driver.browser.mouse.move_to( find('#new_review .rating').native, 120, 10 ).click.perform
        #all(empty_star_selector + ' i').last.trigger(:click)
        expect(page).to have_selector('.rating-container .filled-stars .star', count: 5)
        binding.pry
        expect(page).to have_selector('#review_star_rating', visible: false, text: '5')
      end

      it 'sends review via ajax', js: true do
        visit location_path(location)
        expect do
          fill_in 'review_body', with: 'Message text'
          click_button 'Finish'
          expect(page).to have_content user.first_name
        end.to change(Review, :count).by 1
      end

      it 'resets form on successful creation', js: true do
        visit location_path(location)
        fill_in 'review_body', with: 'Message text'
        click_button 'Finish'
        expect(page).to have_content user.first_name
        expect(page).to have_selector('#review_body', text: '')
        expect(page).to have_selector('#review_star_rating', visible: false, text: '')
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