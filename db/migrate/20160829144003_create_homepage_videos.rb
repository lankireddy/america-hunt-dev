class CreateHomepageVideos < ActiveRecord::Migration
  def change
    create_table :homepage_videos do |t|
      t.string :name
      t.decimal :order
      t.boolean :published

      t.timestamps null: false
    end
  end
end
