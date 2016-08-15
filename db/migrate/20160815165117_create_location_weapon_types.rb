class CreateLocationWeaponTypes < ActiveRecord::Migration
  def change
    create_table :location_weapon_types do |t|
      t.integer :location_id
      t.integer :weapon_type_id

      t.timestamps null: false
    end
  end
end
