class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :travelier_id
      t.string :name
      t.text :website
      t.text :contact_page
      t.string :phone
      t.string :email
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :zip
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :long, precision: 10, scale: 6
      t.date :opening_date
      t.boolean :featured
      t.boolean :follow_up
      t.text :description

      t.timestamps null: false
    end
  end
end
