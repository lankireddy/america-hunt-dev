class CreateLocationSpecies < ActiveRecord::Migration
  def change
    create_table :location_species do |t|
      t.integer :location_id
      t.integer :species_id

      t.timestamps null: false
    end
  end
end
