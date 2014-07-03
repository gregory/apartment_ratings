require 'spec_helper'

describe ApartmentRatings do
  describe '.configure' do
    let(:username) { 'bar' }
    let(:password) { 'foo' }

    subject { described_class.config }

    before do
      described_class.configure do |config|
        config.username = username
        config.password = password
      end
    end

    context 'when format is specified' do
      let(:format) { 'format' }

      before { described_class.config.format = format }

      it 'sets the format' do
        expect(subject.format).to eq format
      end
    end

    it 'sets the right config' do
      expect(subject.username).to eq username
      expect(subject.password).to eq password
      expect(subject.format).to eq subject.class::DEFAULTS[:format]
    end
  end
end
