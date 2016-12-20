class AddFeaturedPositionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :featured_position, :string
  end
end
