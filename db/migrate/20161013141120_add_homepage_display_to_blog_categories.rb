class AddHomepageDisplayToBlogCategories < ActiveRecord::Migration
  def change
    remove_column :blog_categories, :homepage_display
    remove_column :blog_categories, :layout
    add_column :blog_categories, :homepage_display, :integer, default: 0
    BlogCategory.update_all(homepage_display: 0)
  end
end
