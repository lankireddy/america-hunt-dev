class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :author, class_name: 'AdminUser'

  validates :title, presence: true

  def to_s
    title
  end
end
