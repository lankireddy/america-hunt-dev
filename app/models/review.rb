class Review < ActiveRecord::Base
  belongs_to :submitter, class_name: 'User'
  belongs_to :location

  enum status: [:approved, :pending, :unapproved]

  validates :location, :submitter, presence: true
  validates :star_rating, numericality: { greater_than_or_equal_to: 0.5 }, if: 'body.blank?'
  validates :body, presence: true, if: 'star_rating.nil? || star_rating.zero?'
  validates :status, inclusion: { in: statuses.keys }

  paginates_per 10

  scope :rated, -> { where.not(star_rating: [0, nil]) }

end
