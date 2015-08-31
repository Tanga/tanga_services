require 'httparty'
require 'http/exceptions'
require 'json'

module Dino
  class HTTP
    class Exception < RuntimeError
    end

    def self.get(*args)
      new(:get, *args).call
    end

    def self.put(*args)
      new(:put, *args).call
    end

    def self.delete(*args)
      new(:delete, *args).call
    end

    def self.post(*args)
      new(:post, *args).call
    end

    def initialize(method, *args)
      @method = method
      @args = *args
    end

    def call
      begin
        Http::Exceptions.wrap_and_check do
          response = HTTParty.send(@method, *@args)
          response.parsed_response # See that the response can be accessed
          response
        end
      rescue Http::Exceptions::HttpException, JSON::ParserError
        fail Dino::HTTP::Exception
      end
    end
  end
end
