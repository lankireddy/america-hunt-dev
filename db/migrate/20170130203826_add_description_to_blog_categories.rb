class AddDescriptionToBlogCategories < ActiveRecord::Migration
  def change
    add_column :blog_categories, :description, :text
  end
end
