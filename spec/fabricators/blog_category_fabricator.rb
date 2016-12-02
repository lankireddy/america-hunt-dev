Fabricator(:blog_category) do
  name             { Faker::Book.genre.strip }
  homepage_display 'not_visible'
end
