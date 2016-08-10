class AddExternalLinkToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :external_link, :text
  end
end
