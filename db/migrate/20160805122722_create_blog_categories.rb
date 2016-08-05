class CreateBlogCategories < ActiveRecord::Migration
  def change
    create_table :blog_categories do |t|
      t.string :name
      t.boolean :homepage_display
      t.integer :layout

      t.timestamps null: false
    end
  end
end
