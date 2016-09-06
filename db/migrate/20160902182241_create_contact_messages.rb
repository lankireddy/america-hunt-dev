class CreateContactMessages < ActiveRecord::Migration
  def change
    create_table :contact_messages do |t|
      t.string :email
      t.string :subject
      t.text :body

      t.timestamps null: false
    end
  end
end
