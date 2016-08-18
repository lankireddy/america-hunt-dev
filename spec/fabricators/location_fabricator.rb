Fabricator(:location) do
  name         { Faker::Company.name }
  website      { Faker::Internet.url }
  contact_page { Faker::Internet.url }
  phone        { Faker::PhoneNumber.phone_number }
  email        { Faker::Internet.email }
  address_1    { Faker::Address.street_address }
  address_2    { Faker::Address.secondary_address }
  city         { Faker::Address.city }
  state        { Faker::Address.state }
  zip          { Faker::Address.zip }
  lat          { Faker::Address.latitude }
  long         { Faker::Address.longitude }
  description  { Faker::Lorem.paragraph }
  hunting_area_size { Faker::Lorem.sentence }
  terrain  { Faker::Lorem.paragraph }
  status       'approved'
end
