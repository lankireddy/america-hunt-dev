Fabricator(:species) do
  name      { Faker::Pokemon.name }
  parent_id nil
end
