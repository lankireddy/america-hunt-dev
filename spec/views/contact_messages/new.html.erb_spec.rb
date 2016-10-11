RSpec.describe 'contact_messages/new', type: :view do
  include_context 'ad_page'

  before(:each) do
    assign(:contact_message, (Fabricate.build :contact_message))
  end

  it 'renders new contact_message form' do
    render

    assert_select 'form[action=?][method=?]', contact_messages_path, 'post' do
      assert_select 'input#contact_message_email[name=?]', 'contact_message[email]'

      assert_select 'input#contact_message_subject[name=?]', 'contact_message[subject]'

      assert_select 'textarea#contact_message_body[name=?]', 'contact_message[body]'
    end
  end
end
