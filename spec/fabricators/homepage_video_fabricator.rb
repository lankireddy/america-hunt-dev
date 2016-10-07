Fabricator(:homepage_video) do
  name      { Faker::Pokemon.name }
  order     { Faker::Number.decimal(2) }
  published false
  video { File.new("#{Rails.root}/spec/support/files/30 Second Countdown Timer.mp4") }

end
