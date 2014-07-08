module ApartmentRatings
  module Reviews
    class Rating < Hashie::Trash
      property :value

      def self.coerce(raw_rating)
        new(value: raw_rating)
      end
    end
  end
end
