class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.decimal :star_rating
      t.text :body
      t.integer :submitter_id
      t.integer :status
      t.integer :location_id

      t.timestamps null: false
    end
  end
end
