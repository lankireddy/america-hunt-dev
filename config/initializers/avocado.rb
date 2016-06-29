Avocado::Config.configure do |config|
  config.url = nil # replace with 'http://<YOUR SERVER URL>/api-docs/specs' once deployed
  config.headers = ['Authorization']
  config.document_if = -> { ENV['AVOCADO'] }
  config.json_path = Rails.root.join('..', '..', 'shared')
end
