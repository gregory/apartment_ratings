module ApartmentRatings
  class Review < Hashie::Trash
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::Coercion

    property :created_at, from: :datePosted
    property :text, from: :fullReviewText
    property :responses
    property :author, from: :reviewerScreenName
    property :rating, from: :starRatings
    property :updated_at, from: :lastUpdatedDate
    property :url

    coerce_key :responses, Set[ApartmentRatings::Reviews::Response]
    coerce_key :rating, Hash[String => ApartmentRatings::Reviews::Rating]

    def avg_rating
      rating.sum { |_, rating| (rating.value.nil? ? 0 : rating.value) } / [rating.keys.size, 1].max.to_f
    end
  end
end
