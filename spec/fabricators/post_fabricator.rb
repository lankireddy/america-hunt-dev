Fabricator(:post) do
  title { Faker::Commerce.department }
  body  { Faker::Lorem.paragraph }
end

Fabricator(:content_post, from: :post) do
  title { Faker::Commerce.department }
  body  { Faker::Lorem.paragraph }
end
