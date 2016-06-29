ActionMailer::Base.delivery_method = :test

RSpec.configure do |config|
  config.after(:each) do
    ActionMailer::Base.deliveries.clear
  end
end