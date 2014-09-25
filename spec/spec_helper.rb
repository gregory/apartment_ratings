require 'simplecov'

module SimpleCov::Configuration
  def clean_filters
    @filters = []
  end
end

SimpleCov.configure do
  clean_filters
  load_adapter 'test_frameworks'
end

ENV['COVERAGE'] && SimpleCov.start do
  add_filter '/.rvm/'
  add_filter '/.rbenv/'
end
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'yaml'
require 'apartment_ratings'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.before :suite do
    ApartmentRatings.configure do |conf|
      credentials = settings['credentials']

      conf.username = credentials['username']
      conf.password = credentials['password']
    end
  end

  def settings
    @settings ||= YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'spec.yml'))
  end
end
