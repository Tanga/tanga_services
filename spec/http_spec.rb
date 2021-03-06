require 'spec_helper'

describe TS::HTTP do
  %i( get delete post put ).each do |method|
    it method do
      url = 'https://www.tanga.com'
      response = double(parsed_response: 'body', code: 200)
      expect(HTTParty).to receive(method).with(url, options: ['here']) { response }
      body = described_class.send(method, 'https://www.tanga.com', options: ['here'])
      expect(body).to be == response
    end
  end

  it 'handles json parse error' do
    VCR.use_cassette('invalid json') do
      expect do
        described_class.get('https://rawgit.com/joevandyk/a370a1fd94a3e6f88e08/raw/9acc356880ee36e8fd1585db1f1c1582ab3c89ad/bad.json')
      end.to raise_error(described_class::Exception, /unexpected token/)
    end
  end

  it 'puts response code on invalid requests' do
    VCR.use_cassette('422 request') do
      begin
        described_class.get('https://httpbin.org/status/418')
        fail 'i should not get here'
      rescue => e
        expect(e.code).to be == 418
      end
    end
  end

  it 'handles response code if no response' do
    VCR.use_cassette('invalid json') do
      begin
        described_class.get('https://rawgit.com/joevandyk/a370a1fd94a3e6f88e08/raw/9acc356880ee36e8fd1585db1f1c1582ab3c89ad/bad.json')
        fail 'i should not get here'
      rescue => e
        expect(e.code).to be nil
      end
    end
  end
end
