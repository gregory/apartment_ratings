module ApartmentRatings
  class Configuration < Hashie::Dash
    DEFAULTS = {
      format: 'json',
      debug: false,
      api_base_path: 'https://services.apartmentratings.com/services/rms/v1/',
      hours_before_token_expiration: 48,
      max_token_retry: 2
    }.freeze

    property :username
    property :password
    property :debug, default: DEFAULTS[:debug]
    property :faraday_adapter
    property :max_token_retry, default: DEFAULTS[:max_token_retry]
    property :format, default: DEFAULTS[:format]
    property :api_base_path, default: DEFAULTS[:api_base_path]
    property :hours_before_token_expiration, default: DEFAULTS[:hours_before_token_expiration]
  end
end
