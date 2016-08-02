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

  EXCERPT_LENGTH = 40

  geocoded_by :geocode_street_address, latitude: :lat, longitude: :long
  after_validation :geocode, if: ->(obj){ obj.address_present? && obj.address_changed? && !obj.coordinates_changed?}

  def address_present?
    address_1.present? && city.present? && state.present?
  end

  def address_changed?
    address_1_changed? || city_changed? || state_changed?
  end

  def coordinates_changed?
    lat_changed? || long_changed?
  end

  def geocode_street_address
    [address_1, city, state].join(', ')
  end

  def to_s
    name
  end

  def excerpt
    description.truncate_words(EXCERPT_LENGTH)
  end

  def city_state
    "#{city}, #{state}"
  end
end
