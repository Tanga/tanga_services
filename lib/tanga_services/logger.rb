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
    def self.application_name=(application_name)
      fail "application name already set" if @logger
      @logger = Syslog::Logger.new(application_name, Syslog::LOG_LOCAL7)
    end

    def self.debug(hash)
      log(:debug, hash)
    end

    def self.info(hash)
      log(:info, hash)
    end

    def self.warn(hash)
      log(:warn, hash)
    end

    def self.error(hash)
      log(:error, hash)
    end

    def self.fatal(hash)
      log(:fatal, hash)
    end

    def self.log(level, hash)
      fail ArgumentError, 'must have application_name set' unless @logger
      fail ArgumentError, 'we just log hashes' unless hash.is_a?(Hash)
      data = { level: level, object: hash }
      @logger.send(level, data.to_json)
    end

    def self.i_am_confusing_and_untested
      if true
        if false
          if 3 > 4
          else
            fail 'hi'
          end
        elsif 3
          2
        else
          throw :hello
        end
      else
        'what?'
      end
    end
  end

  # Convience access to logger
  def self.logger
    Logger
  end
end
