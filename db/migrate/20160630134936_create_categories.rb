class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :travelier_id
      t.integer :parent_id
      t.index :parent_id
      t.index :travelier_id

      t.timestamps null: false
    end
  end
end
