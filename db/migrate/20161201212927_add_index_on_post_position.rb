class AddIndexOnPostPosition < ActiveRecord::Migration
  def change
    add_index :posts, :position
  end
end
