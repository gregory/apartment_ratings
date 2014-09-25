module ApartmentRatings
  class Address < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess

    property :full_address

    def self.coerce(raw_address)
      new(full_address: raw_address)
    end
  end
end
