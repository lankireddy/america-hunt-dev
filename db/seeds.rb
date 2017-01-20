# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', name: 'Administrator')
admin_id =  AdminUser.first.id
Page.find_or_create_by(title: 'Press & Media', slug: 'press-&amp;-media', author_id: admin_id) do |page|
  page.body = '<p>Words</p>'
end

['About', 'FAQ', 'Newsletter', 'Terms of Service', 'Privacy Policy'].each do |title|
  Page.find_or_create_by(title: title, slug: title.parameterize, author_id: admin_id) do |page|
    page.body = '<p>Words</p>'
  end
end
BlogCategory::STATIC_CATEGORIES.each do |category_key|
  BlogCategory.find_or_create_by(name: I18n.t(:name, scope: [:categories, category_key]))
end
