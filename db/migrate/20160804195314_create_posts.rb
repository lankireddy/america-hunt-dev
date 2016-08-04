class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :subtitle
      t.string :slug
      t.text :body

      t.timestamps null: false
    end
    add_index :posts, :slug, unique: true
  end
end
