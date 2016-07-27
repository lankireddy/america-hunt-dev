require 'spec_helper'

RSpec.describe 'categories/index', type: :view do
  let(:categories) { Fabricate.times 2, :category }
  before(:each) do
    assign(:categories, categories)
  end

  it 'renders a list of categories' do
    render
    categories.each do |category|
      expect(rendered).to include(ERB::Util.html_escape(category.name))
    end
  end
end
