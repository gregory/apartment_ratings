require 'hashie'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'apartment_ratings'))

module ApartmentRatings
  autoload :Configuration, 'configuration'

  class<<self
    attr_accessor :config
  end

  def self.configure
    @config = Configuration.new.tap { |configuration| yield(configuration) }
  end
end
