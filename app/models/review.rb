class Review < ActiveRecord::Base
  belongs_to :submitter, class_name: 'User'
  belongs_to :location

  validates :star_rating, :location, :submitter, presence: true

  enum status: [:approved, :pending, :unapproved]

end
