Fabricator(:post) do
  title { Faker::Commerce.department }
  body  { Faker::Lorem.paragraph }
  external_link  { Faker::Internet.url }
  featured_image { File.new("#{Rails.root}/spec/support/files/4.jpg") }

end

Fabricator(:content_post, from: :post) do
  title { Faker::Commerce.department }
  body  { Faker::Lorem.paragraph }
  featured_image { File.new("#{Rails.root}/spec/support/files/4.jpg") }
end

Fabricator(:link_post, from: :post) do
  title { Faker::Commerce.department }
  external_link  { Faker::Internet.url }
  body ''
end
