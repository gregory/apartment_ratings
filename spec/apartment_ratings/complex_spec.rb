require 'spec_helper'

describe ApartmentRatings::Complex do
  let(:hash) do
    {
      id: '1234',
      name: 'Complex Name',
      address: '1234 Complex St, The City, ST 55001',
      feedUrl: 'https://services.apartmentratings.com/services/rms/v1/complex?complexId=1234',
      averageRating: {
        'construction' => nil,
        'grounds' => 2,
        'maintenance' => 2.5,
        'neighbordhood' => 0,
        'noise' => 2.5,
        'safety' => 2,
        'staff' => 2.5
      },
      percentageRecommanded: '50%',
      reviews: [
        {
          datePosted: 'Mar 21, 2012',
          fullReviewText: %(I currently live there but moving out soon and it has been all not so great.
                        Mold on my walls from all the water leaks from the roof.),
          responses: [
            {
              datePosted: 'Jun 19, 2014',
              fullText: 'Thanks for your review, we will take care of the problems.',
              responderScreenName: 'adasaev'
            },
            {
              datePosted: 'Jun 19, 2014',
              fullText: 'Hello, let us work on the issue. \n\nThanks',
              responderScreenName: 'Manager Response'
            }
          ],
          reviewerScreenName: 'anonymous',
          starRatings: {
            'construction' => nil,
            'grounds' => 2,
            'maintenance' => 2.5,
            'neighbordhood' => 0,
            'noise' => 2.5,
            'safety' => 2,
            'staff' => 2.5
          },
          url: 'http://www.apartmentratings.com/rate/CA-Los-Angeles-Da-Capo-Building-1409821.html'
        }
      ]
    }
  end

  describe '.new(hash)' do
    subject { described_class.new(hash) }

    it 'build a valid Complex from a hash' do
      expect(subject.id).to eq hash[:id]
      expect(subject.name).to eq hash[:name]
      expect(subject.feedUrl).to eq hash[:feedUrl]
      expect(subject.address).to be_a ApartmentRatings::Address
      expect(subject.averageRating).to be_a Hash
      expect(subject.averageRating.values.map(&:class).uniq).to eq [ApartmentRatings::Reviews::Rating]
      expect(subject.reviews).to be_a Set
      expect(subject.reviews.map(&:class).uniq).to eq [ApartmentRatings::Review]
    end

    context 'when the keys dont match' do
      let(:hash) do
        {
          propertyAddress: '1234 Complex St, The City, ST 55001',
          propertyName: 'Complex Name'
        }
      end

      it 'transforms the keys properly' do
        expect(subject.name).to eq hash[:propertyName]
        expect(subject.address).to be_a ApartmentRatings::Address
      end
    end
  end
end
