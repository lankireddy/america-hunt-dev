class AddStatusAuthorIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :status, :integer
    add_column :locations, :author_id, :integer
  end
end
