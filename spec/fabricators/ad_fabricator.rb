Fabricator(:ad) do
  name { Faker::Company.name }
  url  { Faker::Internet.url }
  slot 'sidebar'
  image { File.new("#{Rails.root}/spec/support/files/4.jpg") }
end
