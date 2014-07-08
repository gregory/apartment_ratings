require 'hashie'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'apartment_ratings'))

module ApartmentRatings
  autoload :Configuration, 'configuration'
  autoload :Client, 'client'
  autoload :Address, 'address'
  autoload :Complex, 'complex'
  autoload :Review, 'review'

  module Reviews
    autoload :Rating, 'reviews/rating'
    autoload :Response, 'reviews/response'
  end

  class<<self
    attr_reader :config
  end

  def self.configure
    @config = Configuration.new.tap { |configuration| yield(configuration) }
  end

  def self.client
    options = {
      username: config.username,
      password: config.password,
      api_base_path: config.api_base_path
    }
    Client.new(options)
  end
end
