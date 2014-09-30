require 'hashie'
require 'tnt'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'apartment_ratings'))

module ApartmentRatings
  module Reviews
    autoload :Rating, 'reviews/rating'
    autoload :Response, 'reviews/response'
  end

  require 'review'
  require 'configuration'
  require 'client'
  require 'errors'
  require 'address'
  require 'complex'

  class<<self
    attr_reader :config
  end

  def self.configure
    @config = ApartmentRatings::Configuration.new.tap { |configuration| yield(configuration) }
  end

  def self.credentials
    if config.nil?
      fail ApartmentRatings::Errors::InvalidConfig
    else
      config.select { |key, _| [:username, :password].include?(key) }
    end
  end

  def self.client
    @client ||= begin
      fail ApartmentRatings::Errors::InvalidConfig if config.nil?
      options = {
        api_base_path: config.api_base_path
      }
      ApartmentRatings::Client.new(options)
    end
  end

  def self.post(url = nil, params = {}, headers = nil, errors_opts = { token: 0 }, &block)
    payload     = default_params.merge(params)
    json_result = client.connection.post(url, payload, headers).body
    result      = JSON.parse json_result

    if !result['errors'].nil? && !result['errors']['serviceToken'].nil?
      # Mostlikely the token expired, lets try to refresh it
      fail ApartmentRatings::Errors::InvalidToken unless errors_opts[:token] < ApartmentRatings.config.max_token_retry

      client.refresh_token
      return post(url, params, headers, { token: (errors_opts[:token] + 1) }, &block)
    else
      block.call(result)
    end
  end

  def self.default_params
    {
      serviceToken: client.token,
      username: credentials[:username]
    }
  end
end
