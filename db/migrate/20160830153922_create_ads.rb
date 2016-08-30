class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :name
      t.string :url
      t.integer :slot
      t.index :slot

      t.timestamps null: false
    end
  end
end
