Fabricator(:location) do
  name         Faker::Company.name
  website      Faker::Internet.url
  contact_page Faker::Internet.url
  phone        Faker::PhoneNumber.phone_number
  email        Faker::Internet.email
  address_1    Faker::Address.street_address
  address_2    Faker::Address.secondary_address
  city         Faker::Address.city
  zip          Faker::Address.zip
  lat          Faker::Address.latitude
  long         Faker::Address.longitude
  opening_date Faker::Date.backward(1000)
  featured     false
  follow_up    false
  description  Faker::Lorem.paragraph
end
