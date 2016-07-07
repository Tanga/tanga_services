require 'httparty'
require 'http/exceptions'
require 'json'
require 'active_support'
require 'active_support/core_ext'

module TangaServices
  class HTTP
    class Exception < RuntimeError
      def to_s
        cause.to_s
      end

      def code
        cause.try(:response).code
      end
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
