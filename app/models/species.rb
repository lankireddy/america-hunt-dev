class Species < ActiveRecord::Base
  belongs_to :parent, class_name: Species
  has_many :children, class_name: Species, foreign_key: :parent_id
  has_many :locations, through: :location_species
  has_many :location_species

  validates :name, presence: true

  default_scope { order :name}

  scope :top_level, -> { where(parent_id: nil) }

  scope :specific, -> { where.not(parent_id: nil) }

  def to_s
    name
  end
end
