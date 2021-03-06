class Location < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :name,
      [:name, :state],
      [:name, :city, :state]
    ]
  end

  has_many :location_categories, dependent: :destroy
  has_many :categories, through: :location_categories
  has_many :species, through: :location_species
  has_many :location_species
  has_many :weapon_types, through: :location_weapon_types
  has_many :location_weapon_types
  has_many :reviews
  belongs_to :author, class_name: 'AdminUser'
  belongs_to :submitter, class_name: 'User'

  validates :travelier_id, uniqueness: true, allow_nil: true
  validates :name, :state, :city, :zip, presence: true

  has_attached_file :featured_image, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :featured_image, content_type: /\Aimage\/.*\z/

  enum handicap_status: [:handicap_na, :handicap_inaccessible, :handicap_accessible, :handicap_limited, :handicap_unknown]
  enum child_status: [:children_na, :child_centered, :children_allowed, :children_not_allowed, :children_limited, :children_unknown]
  enum pet_status: [:pet_na, :pet_yes, :pet_service, :pet_no, :pet_limited, :pet_unknown]
  enum status: [:approved, :pending, :unapproved, :modified]

  EXCERPT_LENGTH = 40
  EXCLUDED_STATES = %w(AA GU AE AP AS DC VI UM PR MP).freeze

  geocoded_by :geocode_street_address, latitude: :lat, longitude: :long
  after_validation :geocode, if: ->(obj) { obj.address_present? && obj.address_changed? && !obj.coordinates_changed? }

  paginates_per 10

  def should_generate_new_friendly_id?
    slug.blank?
  end

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
    description.try(:truncate_words, EXCERPT_LENGTH)
  end

  def city_state
    "#{city}, #{state}"
  end

  def average_star_rating
    reviews.approved.rated.average(:star_rating)
  end

  def self.states
    Country['US'].states.except(*Location::EXCLUDED_STATES).map { |abbreviation, properties| [properties['name'], abbreviation] }
  end
end
