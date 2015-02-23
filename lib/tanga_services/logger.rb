require 'syslog/logger'
require 'json'

module TangaServices
  class Logger < Syslog::Logger
    def self.open(application_name)
      @logger ||= Syslog::Logger.new(application_name, Syslog::LOG_LOCAL7)
    end

    def self.method_missing(method, data, &block)
      log = { level: method, data: data }
      @logger.send(method, log.to_json, &block)
    end
  end

  # Convience access to logger
  def self.logger
    Logger
  end
end
