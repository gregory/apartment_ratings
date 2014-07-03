module ApartmentRatings
  class Configuration < Hashie::Dash
    DEFAULTS = {
      format: 'json',
      api_base_path: 'https://services.apartmentratings.com/services/rms/v1/'
    }.freeze

    property :username
    property :password
    property :format, default: DEFAULTS[:format]
    property :api_base_path, default: DEFAULTS[:api_base_path]
  end
end
