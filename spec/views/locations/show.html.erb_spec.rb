require 'spec_helper'

RSpec.describe 'locations/show', type: :view do
  include_context 'ad_page'

  let!(:user) { Fabricate :user}

  before(:each) do

    @location = Fabricate :location
    @previous_page = '/locations?query=Portland, tX'
    @page_title = 'America Hunt: ' + @location.name
    @page_description = @location.excerpt
  end

  it 'displays name in title' do
    render
    expect(rendered).to have_selector('h1', text:@location.name)
  end

  it 'displays description' do
    render
    expect(rendered).to include @location.description
  end

  it 'has link back to search page' do
    render
    expect(rendered).to have_link('Back to search results', href: @previous_page)
  end

  it 'displays 4 approved reviews' do
    Fabricate.times 6, :review, location: @location, status: 'approved'
    Fabricate.times 2, :review, location: @location, status: 'pending'
    render
    expect(rendered).to have_selector('article.review', count: 4)
  end

  it 'has a link to the review form anchor' do
    render
    expect(rendered).to have_link('Write a Review')
  end



  context 'as signed in user' do
    before do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(user)
      allow(view).to receive(:policy).and_return(double('some policy', new?: true))
    end
    it 'has review form as logged in user' do
      render
      assert_select 'form[action=?][method=?]', location_reviews_path(@location), 'post'
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
