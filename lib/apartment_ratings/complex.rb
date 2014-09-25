module ApartmentRatings
  class Complex < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::Coercion

    property :id
    property :name, from: :propertyName
    property :address, from: :propertyAddress
    property :propertyAddress
    property :feedUrl
    property :url, from: :propertyUrl

    property :apartmentRating
    property :averageRating
    property :percentageRecomanded
    property :reviews

    coerce_key :address, Address
    coerce_key :averageRating, Hash[String => Reviews::Rating]
    coerce_key :reviews, Set[Review]

    def self.all
      ApartmentRatings.post('index') do |result|
        if result['success']
          result['complexes'].map { |complex_json| new complex_json }
        else
          fail StandardError
        end
      end
    end

    def self.find(id)
      ApartmentRatings.post('complex', complexId: id) do |result|
        if result['success']
          default_options = { id: id }
          new default_options.merge(result)
        else
          fail Errors::InvalidComplexId.new(id, result['errorMessage'])
        end
      end
    end
  end
end
