Fabricator(:category) do
  name         Faker::Commerce.department
  travelier_id Faker::Number.between(1,10000)
end
