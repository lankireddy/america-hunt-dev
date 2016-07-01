class AddIndexes < ActiveRecord::Migration
  def change
    add_index(:locations, :travelier_id)
    add_index(:admin_users, :name)
  end
end
