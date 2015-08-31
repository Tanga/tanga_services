require 'spec_helper'

describe Dino::HTTP do
  %i( get delete post put ).each do |method|
    it method do
      url = 'https://www.tanga.com'
      response = double(parsed_response: 'body', code: 200)
      expect(HTTParty).to receive(method).with(url) { response }
      body = Dino::HTTP.send(method, 'https://www.tanga.com')
      expect(body).to be == response
    end
  end

  it 'handles json parse error' do
    VCR.use_cassette('invalid json') do
      expect do
        Dino::HTTP.get('https://rawgit.com/joevandyk/a370a1fd94a3e6f88e08/raw/9acc356880ee36e8fd1585db1f1c1582ab3c89ad/bad.json')
      end.to raise_error(Dino::HTTP::Exception)
    end
  end
end
