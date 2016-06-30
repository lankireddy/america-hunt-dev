class AddHandicapStatusChildStatusPetStatusToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :handicap_status, :integer
    add_column :locations, :child_status, :integer
    add_column :locations, :pet_status, :integer
  end
end
