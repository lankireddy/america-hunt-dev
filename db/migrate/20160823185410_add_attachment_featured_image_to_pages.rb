# noinspection RubyClassModuleNamingConvention
class AddAttachmentFeaturedImageToPages < ActiveRecord::Migration
  def self.up
    change_table :pages do |t|
      t.attachment :featured_image
    end
  end

  def self.down
    remove_attachment :pages, :featured_image
  end
end
