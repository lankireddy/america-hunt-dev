class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps null: false
    end
    add_index :species, :parent_id
  end
end
