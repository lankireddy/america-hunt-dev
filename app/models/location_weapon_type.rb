class LocationWeaponType < ActiveRecord::Base
  belongs_to :location
  belongs_to :weapon_type
end
