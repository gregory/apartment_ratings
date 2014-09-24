module ApartmentRatings
  module Reviews
    class Rating < Hashie::Trash
      include Hashie::Extensions::IndifferentAccess
      property :value

      def self.coerce(raw_rating)
        new(value: raw_rating)
      end
    end
  end
end
