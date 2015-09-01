require 'httparty'
require 'http/exceptions'
require 'json'

module TangaServices
  class HTTP
    class Exception < RuntimeError
    end

    %i( get put delete post ).each do |method|
      define_singleton_method(method) do |*args|
        new(method, *args).call
      end
    end

    def initialize(method, *args)
      @method = method
      @args   = *args
    end

    def call
      begin
        Http::Exceptions.wrap_and_check do
          response = HTTParty.send(@method, *@args)
          response.parsed_response # See that the response can be accessed
          response
        end
      rescue Http::Exceptions::HttpException, JSON::ParserError
        fail TangaServices::HTTP::Exception
      end
    end
  end
end
