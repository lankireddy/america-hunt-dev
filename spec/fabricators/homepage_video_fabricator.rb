Fabricator(:homepage_video) do
  name      "MyString"
  order     "9.99"
  published false
  video { File.new("#{Rails.root}/spec/support/files/30 Second Countdown Timer.mp4") }

end
