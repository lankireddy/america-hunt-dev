Fabricator(:weapon_type) do
  name      { sequence(:weapon_type) { |i| "#{Faker::Commerce.department} WT ##{i}" } }
end
