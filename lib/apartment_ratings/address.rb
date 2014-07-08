module ApartmentRatings
  class Address < Hashie::Trash
    property :full_address

    def self.coerce(raw_address)
      new(full_address: raw_address)
    end
  end
end
