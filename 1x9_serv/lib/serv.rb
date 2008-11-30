# Writen by NuLayer
# Modified with permission by 1X9

module Serv
  class Initializer
    class << self
      
      # Start Serv
      def start!
        Serv::Log.start!
        Serv::Log.info "=> Serv initializing"
        
        initialize_paths
        initialize_database
        initialize_broker
        
      end
      
      # Stop Serv
      def stop!
        Serv::Log.info "=> Stopping Serv..."
        Serv::Log.stop!
        
        AMQP.stop do
          EM.stop
          exit
        end
      end
      
      # Open a connection with the database
      def initialize_database
        Serv::Log.info "-> Connecting to database"
        ActiveRecord::Base.establish_connection(Configuration::database_configuration)
      end
      
      # Open a connect with the broker
      def initialize_broker
        Serv::Log.info "-> Connecting to broker"
        Serv::Log.info "=> Started (CTRL-C to exit)"
        Broker::Base.start!(Configuration::broker_configuration)
      end
      
      # Load the source files in the various defined paths
      def initialize_paths
        paths = [
          'app/controllers',
          'app/models'
        ].each do |path|
          load_path "#{SERV_ROOT}/#{path}"
        end
        
        load_path EXT_MODELS_DIR if defined?(EXT_MODELS_DIR)
      end
      
      # Load the source .rb files
      def load_path(path)
        files = Dir.entries(path).sort.each do |file|
          begin
            load("#{path}/#{file}") if file =~ /.rb/
          rescue
          end
        end
      end
    end
  end
  
  class Configuration
    class << self
      DB_CONFIG_FILE = "#{SERV_ROOT}/config/database.yml"
      BROKER_CONFIG_FILE = "#{SERV_ROOT}/config/broker.yml"
      
      def database_configuration
        YAML::load(ERB.new(IO.read(DB_CONFIG_FILE)).result)
      end
      
      def broker_configuration
        YAML::load(ERB.new(IO.read(BROKER_CONFIG_FILE)).result)
      end
    end
  end
end

Serv::Initializer.start!
