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
    property :percentageRecommended
    property :reviews

    coerce_key :address, ApartmentRatings::Address
    coerce_key :averageRating, Hash[String => ApartmentRatings::Reviews::Rating]
    coerce_key :reviews, Set[ApartmentRatings::Review]

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
          fail ApartmentRatings::Errors::InvalidComplexId.new(id, result['errorMessage'])
        end
      end
    end
  end
end
