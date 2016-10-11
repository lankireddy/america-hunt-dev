describe ContactMessage do
  let(:contact_message) { Fabricate.build :contact_message }

  it 'sends an email' do
    expect { contact_message.send_email }
      .to change { ActionMailer::Base.deliveries.count }.by 1
  end
end
