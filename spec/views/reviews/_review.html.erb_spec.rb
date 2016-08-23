RSpec.describe 'reviews/_review', type: :view do
  before(:each) do
    @review = Fabricate :review
    allow(view).to receive(:review).and_return(@review)
  end

  it 'renders name' do
    render
    expect(rendered).to have_selector('h3', text: @review.submitter)
  end

  it 'renders time ago' do
    render
    expect(rendered).to have_selector('time', text: "#{time_ago_in_words(@review.created_at)} ago")
  end

  it 'renders body' do
    render
    expect(rendered).to have_selector('p', text: @review.body)
  end
end
