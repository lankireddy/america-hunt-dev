class Ad < ActiveRecord::Base
  enum slot: [:top, :sidebar]

  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment_presence :image

  validates :url, :name, presence: true
end
