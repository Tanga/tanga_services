require 'syslog/logger'
require 'json'

module TangaServices
  # Logs json to syslog.
  # Automatically delegates stuff to the syslog logger.
  # Use like:
  #    TangaServices.logger.open('my_application_name')
  #    TangaServices.logger.info({message: "I'm interesting data"})
  #    TangaServices.logger.error({message: "i crashed"})
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
