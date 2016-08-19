RSpec.describe 'reviews/_form', type: :view do
  before(:each) do
    @location = Fabricate :location

    assign(:review, (Fabricate.build :review))
  end

  it 'renders review form' do
    render

    assert_select 'form[action=?][method=?]', location_reviews_path(@location), 'post' do

      assert_select 'input#review_star_rating[name=?]', 'review[star_rating]'

      assert_select 'textarea#review_body[name=?]', 'review[body]'
    end
  end
end
