Fabricator(:user) do
  email { Faker::Internet.email }
  password Faker::Internet.password
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  phone        { Faker::PhoneNumber.phone_number }
  address_1    { Faker::Address.street_address }
  city         { Faker::Address.city }
  state        { Faker::Address.state }
  zip          { Faker::Address.zip }
end
