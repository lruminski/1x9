SERV_LOG  = SERV_ROOT + '/log/serv.log'

module Serv
  module Log
    class << self
      def start!
        @logger = Logger.new(SERV_LOG)
        @logger_stdout = Logger.new(STDOUT) if defined?(DEBUG)
      end
      
      def stop!
        @logger.close
        @logger_stdout.close if defined?(DEBUG)
      end
      
      def info(msg)
        @logger.info msg
        @logger_stdout.info msg if defined?(DEBUG)
      end      
    end
  end
end
