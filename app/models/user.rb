class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable, :recoverable

  has_attached_file :profile_image, styles: { small: "200x200", thumb: "100x100>" }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :profile_image, content_type: /\Aimage\/.*\z/


  validates :first_name, :last_name, presence: true

  def to_s
    [first_name, last_name].join(' ')
  end
end
