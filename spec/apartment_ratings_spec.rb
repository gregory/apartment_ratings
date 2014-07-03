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

    context 'when defaults are sets' do
      let(:format) { 'format' }
      let(:api_base_path) { 'https://services.apartmentratings.com/services/rms/v2/' }
      let(:hours_before_token_expiration) { 72 }

      before do
        described_class.config.format = format
        described_class.config.api_base_path = api_base_path
        described_class.config.hours_before_token_expiration = hours_before_token_expiration
      end

      it 'sets the format' do
        expect(subject.format).to eq format
        expect(subject.api_base_path).to eq api_base_path
        expect(subject.hours_before_token_expiration).to eq hours_before_token_expiration
      end
    end

    it 'sets the right config' do
      expect(subject.username).to eq username
      expect(subject.password).to eq password
      expect(subject.format).to eq subject.class::DEFAULTS[:format]
      expect(subject.api_base_path).to eq subject.class::DEFAULTS[:api_base_path]
      expect(subject.hours_before_token_expiration).to eq subject.class::DEFAULTS[:hours_before_token_expiration]
    end
  end
end
