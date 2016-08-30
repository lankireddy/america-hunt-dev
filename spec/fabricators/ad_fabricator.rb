Fabricator(:ad) do
  name "MyString"
  url  { Faker::Internet.url }
  slot 'sidebar'
  image { File.new("#{Rails.root}/spec/support/files/4.jpg") }
end
