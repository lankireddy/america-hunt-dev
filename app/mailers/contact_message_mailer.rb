class ContactMessageMailer < ApplicationMailer
  default to: 'info@americahunt.com'

  def form_submitted(contact_message)
    @contact_message = contact_message
    mail(from: @contact_message.email, subject: "Contact Us Form: #{@contact_message.subject}")
  end
end
