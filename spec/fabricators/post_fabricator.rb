Fabricator(:post) do
  title { Faker::Commerce.department }
  body  { Faker::Lorem.paragraph }
  external_link  { Faker::Internet.url }
end

Fabricator(:content_post, from: :post) do
  title { Faker::Commerce.department }
  body  { Faker::Lorem.paragraph }
end

Fabricator(:link_post, from: :post) do
  title { Faker::Commerce.department }
  external_link  { Faker::Internet.url }
end
