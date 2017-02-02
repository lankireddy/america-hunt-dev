class AddAttachmentImageToBlogCategories < ActiveRecord::Migration
  def self.up
    change_table :blog_categories do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :blog_categories, :image
  end
end
