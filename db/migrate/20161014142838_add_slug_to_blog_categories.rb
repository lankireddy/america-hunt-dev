class AddSlugToBlogCategories < ActiveRecord::Migration
  def change
    add_column :blog_categories, :slug, :string
    add_index :blog_categories, :slug, unique: true
  end
end
