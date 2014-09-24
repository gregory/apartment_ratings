module ApartmentRatings
  class Review < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::Coercion

    property :datePosted
    property :text, from: :fullReviewText
    property :responses
    property :author, from: :reviewerScreenName
    property :rating, from: :starRatings
    property :updated_at, from: :lastUpdatedDate
    property :url

    coerce_key :responses, Set[Reviews::Response]
    coerce_key :rating, Hash[String => Reviews::Rating]
  end
end
