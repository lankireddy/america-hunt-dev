Fabricator(:contact_message) do
  email   { Faker::Internet.email }
  subject { Faker::Lorem.sentence }
  body    { Faker::Lorem.paragraph }
end
