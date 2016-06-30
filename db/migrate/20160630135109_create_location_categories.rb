class CreateLocationCategories < ActiveRecord::Migration
  def change
    create_table :location_categories do |t|
      t.integer :location_id
      t.integer :category_id
      t.index :location_id
      t.index :category_id
      t.timestamps null: false
    end
  end
end
