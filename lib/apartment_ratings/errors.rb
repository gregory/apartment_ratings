module ApartmentRatings
  module Errors
    InvalidToken = Tnt.boom do
      credentials = ApartmentRatings.credentials.map { |k, v| "#{k} => #{v}" }.join(', ')
      "Unable to retrieve token for the following credentials: #{credentials}"
    end

    InvalidConfig = Tnt.boom do
      %s(
        Please provide valid credentials. Ex:
        > ApartmentRatings.configure { |c| c.username = 'username'; c.password= 'bar'; }
      )
    end

    InvalidComplexId = Tnt.boom do |id, msg|
      "Invalid Complex id (#{id}) : #{msg}"
    end
  end
end
