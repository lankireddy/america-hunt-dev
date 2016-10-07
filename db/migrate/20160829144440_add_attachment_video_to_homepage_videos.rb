# noinspection ALL
class AddAttachmentVideoToHomepageVideos < ActiveRecord::Migration
  def self.up
    change_table :homepage_videos do |t|
      t.attachment :video
    end
  end

  def self.down
    remove_attachment :homepage_videos, :video
  end
end
