Fabricator(:blog_category) do
  name             { Faker::Book.genre }
  homepage_display false
  layout           1
end
