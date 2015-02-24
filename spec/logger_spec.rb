require 'spec_helper'

describe TangaServices do
  before do
    # Clears the logging variable.
    TangaServices::Logger.instance_variable_set(:@logger, nil)
  end

  context '.application_name=' do
    it 'should open the log with application name' do
      logger = instance_double(Syslog::Logger)
      expect(Syslog::Logger).to receive(:new).with('my_app', Syslog::LOG_LOCAL7).and_return(logger)
      TangaServices.logger.application_name = 'my_app'
    end
  end

  context '.log' do
    it 'requires you log a hash' do
      TangaServices.logger.application_name = 'app'
      expect{TangaServices.logger.info('not a hash')}.to \
        raise_error(ArgumentError, "we just log hashes")
    end

    it 'makes you set application name before' do
      expect{TangaServices.logger.info('not a hash')}.to \
        raise_error(ArgumentError, "must have application_name set")
    end

    %w( debug info warn error fatal ).each do |method|
      it "should log #{ method}" do
        logger = instance_double(Syslog::Logger)
        expect(Syslog::Logger).to receive(:new).with('my_app', Syslog::LOG_LOCAL7).and_return(logger)
        expect(logger).to receive(method).with({level: method, object: { joe: 'all right' } }.to_json)
        TangaServices.logger.application_name = 'my_app'
        TangaServices.logger.send(method, joe: 'all right')
      end
    end
  end
end
