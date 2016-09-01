require 'spec_helper'

RSpec.describe 'shared/_newsletter_form', type: :view do
  include_context 'ad_page'
  before(:each) do
    allow(view).to receive(:resource) { (Fabricate.build :user) }
    allow(view).to receive(:resource_name) { :user }
  end

  it 'renders new user form' do
    render
    assert_select 'form#?[method=?]', 'mc-embedded-subscribe-form', 'post' do

      assert_select 'input#mce-EMAIL[name=?]', 'EMAIL'

    end
  end
end
