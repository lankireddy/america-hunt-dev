Fabricator(:post) do
  title { Faker::Commerce.department }
  body  { Faker::Lorem.paragraph }
  external_link  { Faker::Internet.url }
  featured_image { File.new("#{Rails.root}/spec/support/files/4.jpg") }
  blog_categories(count: 1)
  position nil
end

Fabricator(:content_post, from: :post) do
  title { Faker::Commerce.department }
  body  { Faker::Lorem.paragraph }
  featured_image { File.new("#{Rails.root}/spec/support/files/4.jpg") }
end

