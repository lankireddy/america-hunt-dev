class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable, :recoverable

  has_attached_file :profile_image, styles: { small: "200x200", thumb: "100x100>" }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :profile_image, content_type: /\Aimage\/.*\z/

  after_create :sign_up_for_newsletter, if: :newsletter_subscriber

  validates :first_name, :last_name, presence: true

  def to_s
    [first_name, last_name].join(' ')
  end

  def sign_up_for_newsletter
    gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'], debug: true)
    gibbon.lists(ENV['MAILCHIMP_LIST_ID']).members.create(body: subscription_hash)
  end

  def subscription_hash
    {
        email_address: email,
        status: 'subscribed',
        merge_fields: {
            FNAME: first_name,
            LNAME: last_name,
            STATE: state,
            ADDRESS: {
                addr1: address_1,
                city: city,
                state: state,
                zip: zip
            },
            PHONE: phone
        }
    }
  end
end
