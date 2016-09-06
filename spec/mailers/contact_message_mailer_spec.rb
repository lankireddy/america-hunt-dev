
RSpec.describe ContactMessageMailer, type: :mailer do
  describe 'form submitted' do
    let(:contact_message) { Fabricate :contact_message, subject: 'Say what?' }
    let(:mail) { described_class.form_submitted(contact_message).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Contact Us Form: ' + 'Say what?')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq(['info@americahunt.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq([contact_message.email])
    end

    it 'assigns @contact_message' do
      expect(mail.body.encoded).to match(contact_message.body)
    end
  end
end
