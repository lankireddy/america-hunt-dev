require 'spec_helper'

RSpec.describe 'shared/_newsletter_form', type: :view do
  include_context 'ad_page'
  before(:each) do
    allow(view).to receive(:resource) { (Fabricate.build :user) }
    allow(view).to receive(:resource_name) { :user }
  end

  it 'renders new user form' do
    render
    assert_select 'form#mc-embedded-subscribe-form[method=?]', 'post' do

      assert_select 'input#mce-EMAIL[name=?]', 'EMAIL'

    end
  end
end
