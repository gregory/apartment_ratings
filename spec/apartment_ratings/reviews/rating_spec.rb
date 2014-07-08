require 'spec_helper'

describe ApartmentRatings::Reviews::Rating do
  let(:rating) { 2.6 }

  describe '.coerce(raw_rating)' do
    subject { described_class.coerce(rating) }

    it 'coerce the rating and set the value' do
      expect(subject).to be_a described_class
      expect(subject.value).to eq rating
    end
  end
end
