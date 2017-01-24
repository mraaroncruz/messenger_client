module MessengerClient
  class Config
    class << self
      attr_writer :logger

      def logger
        @logger ||= Logger.new(STDOUT)
      end
    end
  end
end
