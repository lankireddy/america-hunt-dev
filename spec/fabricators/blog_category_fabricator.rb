Fabricator(:blog_category) do
  name             { Faker::Book.genre }
  homepage_display 'not_visible'
end
