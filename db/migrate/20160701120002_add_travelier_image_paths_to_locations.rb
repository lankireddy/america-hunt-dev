class AddTravelierImagePathsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :travelier_image_paths, :text
  end
end
