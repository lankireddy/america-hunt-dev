class AddWeightToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :weight, :float, index: true
  end
end
