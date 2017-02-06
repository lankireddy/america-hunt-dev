require 'rubygems'
require 'simplecov'

SimpleCov.start 'rails' do
  add_filter 'lib/templates'
end

ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'avocado/rspec'
require 'rspec/rails'
require 'shoulda/matchers'
require 'paperclip/matchers'
require 'pundit/rspec'
require 'webmock/rspec'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

WebMock.disable_net_connect! allow_localhost: true

ActiveRecord::Migration.maintain_test_schema!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.order = :random
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.render_views = true
  config.expect_with(:rspec) { |c| c.syntax = [:should, :expect] }
  # config.global_fixtures = :all
  # config.fixture_path = Rails.root.join('spec', 'fixtures')
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :view
  config.extend ControllerMacros, type: :controller
  config.example_status_persistence_file_path = 'only-failures.log'
  Capybara::Webkit.configure(&:block_unknown_urls)
  config.include Paperclip::Shoulda::Matchers
  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end

  config.before(:each) do
    Fabricate(:blog_category, name: 'Hunting and Shooting News')
    Fabricate(:blog_category, name: 'State Wildlife Agency News')
    Fabricate(:blog_category, name: 'Hunting Organizations')
  end
end
