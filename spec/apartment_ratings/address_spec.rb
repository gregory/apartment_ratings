require 'spec_helper'

describe ApartmentRatings::Address do
  describe '.new(hash)' do
    let(:hash) { { full_address: '1234 Complex St, The City, ST 55001' } }

    subject { described_class.new(hash) }

    it 'build a valid Address from a hash' do
      expect(subject.full_address).to eq hash[:full_address]
    end
  end

  describe '.coerce(hash)' do
    let(:hash) { { full_address: '1234 Complex St, The City, ST 55001' } }

    subject { described_class.coerce(hash[:full_address]) }

    it 'coerce hash into Address' do
      expect(subject).to be_a ApartmentRatings::Address
      expect(subject.full_address).to eq hash[:full_address]
    end
  end
end
