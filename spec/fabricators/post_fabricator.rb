Fabricator(:post) do
  title { Faker::Commerce.department }
  body  { Faker::Lorem.paragraph }
  external_link  { Faker::Internet.url }
  featured_image nil
  blog_categories(count: 1)
  position nil
  created_at Time.now
end

Fabricator(:post_with_image, from: :post) do
  featured_image { File.new("#{Rails.root}/spec/support/files/4.jpg") }
end
