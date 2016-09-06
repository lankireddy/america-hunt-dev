class ContactMessage < ActiveRecord::Base
  validates :email, :body, presence: true
  validates :email, format: /@/

  after_save :send_email

  def send_email
    ContactMessageMailer.form_submitted(self).deliver_now
  end
end
