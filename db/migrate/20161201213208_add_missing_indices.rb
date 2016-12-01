class AddMissingIndices < ActiveRecord::Migration
  def change
    add_index :blog_categories, :homepage_display

    add_index :blog_category_posts, :post_id
    add_index :blog_category_posts, :blog_category_id

    add_index :location_species, :location_id
    add_index :location_species, :species_id

    add_index :location_weapon_types, :location_id
    add_index :location_weapon_types, :weapon_type_id

    add_index :reviews, :location_id
  end
end
