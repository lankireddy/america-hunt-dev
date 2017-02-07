# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.first_or_create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', name: 'Administrator')
admin_id = AdminUser.first.id
Page.find_or_create_by(title: 'Press & Media', slug: 'press-&amp;-media', author_id: admin_id) do |page|
  page.body = '<p>Words</p>'
end

['About', 'FAQ', 'Newsletter', 'Terms of Service', 'Privacy Policy'].each do |title|
  Page.find_or_create_by(title: title, slug: title.parameterize, author_id: admin_id) do |page|
    page.body = '<p>Words</p>'
  end
end

BlogCategory.find_or_create_by(name: 'Hunting and Shooting News',
                               homepage_display: :widget)
BlogCategory.find_or_create_by(name: 'State Wildlife Agency News',
                               description: "Get the local scoop - the latest field-level 'intel' from each of the states' wildlife and conservation organizations",
                               homepage_display: :secondary_featured)
BlogCategory.find_or_create_by(name: 'Hunting Organizations',
                               homepage_display: :under_widget_text_link,
                               description: 'See our list of hunting, sport shooting and archery organizations')
BlogCategory.find_or_create_by(name: 'The Thin Green Line',
                               description: 'Field notes from state game wardens and wildlife officers from all 50 states and Canada about the encounters of these men and women in green enforcing our game laws',
                               homepage_display: :secondary_featured)
