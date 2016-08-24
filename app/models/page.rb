class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :author, class_name: 'AdminUser'

  validates :title, presence: true

  has_attached_file :featured_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :featured_image, content_type: /\Aimage\/.*\z/

  def to_s
    title
  end
end
