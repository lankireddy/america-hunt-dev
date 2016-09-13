class AddIndexToPostWeight < ActiveRecord::Migration
  def change
    add_index :posts, :weight
  end
end
