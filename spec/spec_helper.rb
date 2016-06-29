require 'rubygems'
require 'simplecov'

SimpleCov.start 'rails' do
  add_filter 'lib/templates'
end

ENV["RAILS_ENV"] = 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'avocado/rspec'
require 'rspec/rails'

require 'webmock/rspec'
WebMock.disable_net_connect! allow_localhost: true

ActiveRecord::Migration.maintain_test_schema!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.order = :random
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.render_views = true
  config.global_fixtures = :all
  config.fixture_path = Rails.root.join('spec', 'fixtures')
  config.include Devise::TestHelpers, type: :controller

  Capybara::Webkit.configure(&:block_unknown_urls)
end
