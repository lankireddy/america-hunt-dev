class HomepageVideo < ActiveRecord::Base
  validates :name, presence: true

  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where.not(published: true) }

  has_attached_file :video
  validates_attachment_content_type :video, content_type: ['video/mp4', 'application/mp4']
  validates_attachment_presence :video
end
