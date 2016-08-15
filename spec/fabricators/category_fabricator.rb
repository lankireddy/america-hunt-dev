Fabricator(:category) do
  name      { sequence(:category) { |i| "#{Faker::Commerce.department} ##{i}" } }
end
