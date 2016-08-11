class LocationSpecies < ActiveRecord::Base
  belongs_to :location
  belongs_to :species
end
