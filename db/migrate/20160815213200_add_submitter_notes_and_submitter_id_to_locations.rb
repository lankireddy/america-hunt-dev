class AddSubmitterNotesAndSubmitterIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :submitter_notes, :text
    add_column :locations, :submitter_id, :integer
  end
end
