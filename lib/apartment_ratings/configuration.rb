module ApartmentRatings
  class Configuration < Hashie::Dash
    DEFAULTS = {
      format: 'json',
      api_base_path: 'https://services.apartmentratings.com/services/rms/v1/',
      hours_before_token_expiration: 48
    }.freeze

    property :username
    property :password
    property :format, default: DEFAULTS[:format]
    property :api_base_path, default: DEFAULTS[:api_base_path]
    property :hours_before_token_expiration, default: DEFAULTS[:hours_before_token_expiration]
  end
end
