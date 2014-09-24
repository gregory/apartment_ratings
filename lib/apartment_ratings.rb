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
    attr_reader :config, :credentials
  end

  def self.configure
    @config = Configuration.new.tap { |configuration| yield(configuration) }
    @credentials = @config.select { |key,_| [:username, :password].include?(key) }
  end

  def self.client
    @client ||= begin
      options = {
        api_base_path: config.api_base_path
      }
      Client.new(options)
    end
  end

  def self.post(url=nil, params={}, headers=nil, errors_opts={token: 0}, &block)
    payload = default_params.merge(params)
    result = JSON.parse client.connection.post(url, payload, headers).body

    if !result['errors'].nil? && !result['errors']['serviceToken'].nil?
      # Mostlikely the token expired, lets try to refresh it
      if errors_opts[:token] < ApartmentRatings.config.max_token_retry
        client.refresh_token
        return post(url, params, headers, { token: errors_opts[:token]+1 }, &block)
      else
        #TODO: handle unable to refresh token
      end
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
