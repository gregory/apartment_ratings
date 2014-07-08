module ApartmentRatings
  module Reviews
    class Response < Hashie::Trash
      property :created_at, from: :datePosted
      property :text, from: :fullText
      property :author, from: :responderScreenName
    end
  end
end
