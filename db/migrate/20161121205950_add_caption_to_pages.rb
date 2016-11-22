class AddCaptionToPages < ActiveRecord::Migration
  def change
    add_column :pages, :caption, :text
  end
end
