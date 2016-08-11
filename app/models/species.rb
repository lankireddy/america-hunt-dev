class Species < ActiveRecord::Base
  belongs_to :parent, class_name: Species
  has_many :children, class_name: Species, foreign_key: :parent_id

  validates :name, presence: true

  scope :top_level, -> { where(parent_id: nil) }

  scope :specific, -> { where.not(parent_id: nil) }

  def to_s
    name
  end
end
