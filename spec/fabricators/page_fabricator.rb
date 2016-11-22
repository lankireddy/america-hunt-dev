Fabricator(:page) do
  title { Faker::Commerce.department }
  body  { Faker::Lorem.paragraph }
  featured_image { File.new("#{Rails.root}/spec/support/files/4.jpg") }
  caption { Faker::Lorem.sentence }
  display_newsletter_sign_up false
end
