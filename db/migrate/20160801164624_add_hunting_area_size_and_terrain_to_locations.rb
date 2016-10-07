# noinspection RubyClassModuleNamingConvention
class AddHuntingAreaSizeAndTerrainToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :hunting_area_size, :string
    add_column :locations, :terrain, :text
  end
end
