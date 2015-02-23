require 'spec_helper'

describe TangaServices do
  context '.log' do
    it 'should log to syslog' do
      logger = instance_double(Syslog::Logger, info: 'sup')
      expect(logger).to receive(:info).with({level: 'info', data: { joe: 'all right' } }.to_json)
      expect(Syslog::Logger).to receive(:new).and_return(logger)
      TangaServices.logger.open('my_app')
      TangaServices.logger.info joe: 'all right'
    end
  end
end
