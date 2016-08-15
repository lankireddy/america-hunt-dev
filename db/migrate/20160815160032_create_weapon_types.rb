class CreateWeaponTypes < ActiveRecord::Migration
  def change
    create_table :weapon_types do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
