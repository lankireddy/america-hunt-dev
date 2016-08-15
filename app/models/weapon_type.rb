class WeaponType < ActiveRecord::Base
  has_many :location_weapon_types, dependent: :destroy
  has_many :locations, through: :location_weapon_types
  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end
