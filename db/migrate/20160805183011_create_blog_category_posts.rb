class CreateBlogCategoryPosts < ActiveRecord::Migration
  def change
    create_table :blog_category_posts do |t|
      t.integer :blog_category_id
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
