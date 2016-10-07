# noinspection ALL
class AddAttachmentFeaturedImageToLocations < ActiveRecord::Migration
  def self.up
    change_table :locations do |t|
      t.attachment :featured_image
    end
  end

  def self.down
    remove_attachment :locations, :featured_image
  end
end
