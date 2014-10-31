require 'rubygems'
require 'bundler/setup'

ENV["RAILS_ENV"] ||= 'test'

require 'rsolr'

require 'engine_cart'
EngineCart.load_application!

require 'rspec/rails'
require 'capybara/rspec'


RSpec.configure do |config|
  config.raise_errors_for_deprecations!

  # workarounds for deprecations
  config.infer_spec_type_from_file_location!
  config.expose_current_running_example_as :example # capybara
end
