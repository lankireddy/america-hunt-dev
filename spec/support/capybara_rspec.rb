require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara-webkit'

Capybara.javascript_driver = :webkit
Capybara.default_max_wait_time = 5

RSpec.configure do |config|
  config.include Capybara::DSL
end
