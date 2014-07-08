require 'faraday'

module ApartmentRatings
  class Client
    def initialize(options = {})
      path = options.fetch(:api_base_path)
      params = {
        username: options.fetch(:username),
        password: options.fetch(:password)
      }

      @client = Faraday.new(path, params) do |faraday|
        faraday.response :json, content_type: /\bjson\z/
        faraday.response :logger if ApartmentRatings.config.debug

        faraday.adapter ApartmentRatings.config.faraday_adapter || Faraday.default_adapter
      end
    end

    def complexes
      result = @client.get('index')
      # TODO: store the result and hangle unsuccessful response
      result['complexes'].map { |complex_json| Complex.new complex_json }
    end

    def complex(id)
      result = @client.get('complex', complexId: id)
      Complex.new result
    end
  end
end
