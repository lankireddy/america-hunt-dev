class Location < ActiveRecord::Base
  has_many :location_categories, dependent: :destroy
  has_many :categories, through: :location_categories
  belongs_to :author, class_name: 'AdminUser'

  validates :travelier_id, uniqueness: true, allow_nil: true
  validates :name, presence: true

  enum handicap_status: [:handicap_na, :handicap_inaccessible, :handicap_accessible, :handicap_limited, :handicap_unknown]
  enum child_status: [:children_na, :child_centered, :children_allowed, :children_not_allowed, :children_limited, :children_unknown]
  enum pet_status: [:pet_na, :pet_yes, :pet_service, :pet_no, :pet_limited, :pet_unknown]
  enum status: [:approved, :pending, :unapproved, :modified]

  def to_s
    name
  end
end
