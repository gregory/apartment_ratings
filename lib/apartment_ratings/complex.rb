module ApartmentRatings
  class Complex < Hashie::Trash
    include Hashie::Extensions::IgnoreUndeclared
    include Hashie::Extensions::Coercion

    property :id
    property :name, from: :propertyName
    property :address, from: :propertyAddress
    property :propertyAddress
    property :feedUrl

    property :apartmentRating
    property :averageRating
    property :percentageRecomanded
    property :reviews

    coerce_key :address, Address
    coerce_key :averageRating, Hash[String => Reviews::Rating]
    coerce_key :reviews, Set[Review]
  end
end
