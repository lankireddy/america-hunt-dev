Fabricator(:page) do
  title { Faker::Commerce.department }
  body  { Faker::Lorem.paragraph }
end
