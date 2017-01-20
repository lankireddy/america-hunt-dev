Fabricator(:species) do
  name { sequence(:species) { |i| "#{Faker::Pokemon.name} ##{i}" } }
  parent_id nil
end

Fabricator(:top_level_species, from: :species) do
  name { sequence(:species) { |i| "Top Level Species ##{i}" } }
  parent_id nil
end
