module ApartmentRatings
  class Configuration < Hashie::Dash
    DEFAULTS = {
      format: 'json'
    }.freeze

    property :username
    property :password
    property :format, default: DEFAULTS[:format]
  end
end
