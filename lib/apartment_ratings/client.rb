require 'faraday'
require 'faraday_middleware'

module ApartmentRatings
  class Client
    attr_reader :connection

    def initialize(options = {})
      path = options.fetch(:api_base_path)

      @connection = Faraday.new(path) do |faraday|
        faraday.request :url_encoded # Unfortunately, we need to encode post and put params
        faraday.request :json

        # NOTE: Unfortunately, the response content type is not json... But we know it is.
        faraday.response :json, content_type: /\Atext\/html;charset=ISO-8859-1\z/
        faraday.response :logger if ApartmentRatings.config.debug

        faraday.adapter ApartmentRatings.config.faraday_adapter || Faraday.default_adapter
      end
    end

    def token
      @token ||= refresh_token
    end

    def refresh_token
      @token = nil
      result = JSON.parse @connection.post('login', ApartmentRatings.credentials.merge(format: 'json')).body

      if result['success']
        @token = result['response']
      else
        fail Errors::InvalidToken
      end
    end
  end
end
