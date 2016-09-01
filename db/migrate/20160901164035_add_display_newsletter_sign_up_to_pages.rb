class AddDisplayNewsletterSignUpToPages < ActiveRecord::Migration
  def change
    add_column :pages, :display_newsletter_sign_up, :boolean
  end
end
