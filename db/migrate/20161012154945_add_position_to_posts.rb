class AddPositionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :position, :integer
    Post.where.not(weight:nil).order(:weight).each_with_index { |post, index | post.update(position: index) }
    remove_column :posts, :weight
  end
end
