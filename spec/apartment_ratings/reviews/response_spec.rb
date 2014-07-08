require 'spec_helper'

describe ApartmentRatings::Reviews::Response do
  let(:response) do
    {
      datePosted: 'Jun 19, 2014',
      fullText: 'Thanks for your review, we will take care of the problems.',
      responderScreenName: 'adasaev'
    }
  end

  describe '.new(response)' do
    subject { described_class.new(response) }

    it 'build a valid Response from a hash' do
      expect(subject).to be_a described_class
      expect(subject.created_at).to eq response[:datePosted]
      expect(subject.text).to eq response[:fullText]
      expect(subject.author).to eq response[:responderScreenName]
    end
  end
end
