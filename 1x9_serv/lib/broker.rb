# Writen by NuLayer
# Modified with permission by 1X9

module Broker
  require "activesupport"
  module Base
    USERS_TOPIC = "users"
    
    class << self
      def start!(config)
        host          = config['connection']['host']
        user          = config['connection']['user']
        pass          = config['connection']['pass']
        vhost         = config['connection']['vhost']
        game_exchange = config['subscription']['game_exchange']
        serv_exchange = config['subscription']['serv_exchange']
        serv_queue    = config['subscription']['serv_queue']

        trap_exit_signal('TERM')

        AMQP.run(:host => host, :user => user, :pass => pass, :vhost => vhost) do
          trap_exit_signal('INT')
          
          # Serv exchange communication
          @serv_mq = MQ.new
          directx = @serv_mq.direct(serv_exchange)
          
          # Game exchange communication
          @game_mq = MQ.new.topic(game_exchange)
        
          #########################################################################################
        
          # Serv queue block that subscribes to the direct exchange and listens for requests
          @serv_mq.queue(serv_queue, :auto_delete => true).bind(directx, :routing_key => serv_queue).subscribe do |info, msg|
            req_start_time = Time.now
            result = dispatch(msg)
            req_end_time = Time.now
            
            log "[RESULT] - (#{req_end_time-req_start_time} sec) [#{result}]"
            @serv_mq.queue(info.reply_to).publish(result, :correlation_id => info.correlation_id)
          end

          #########################################################################################
          
          # Parse the request from the message, call the specified controller and return the result
          def dispatch(msg)
            ActiveRecord::Base.establish_connection(Serv::Configuration::database_configuration)

            msg = JSON.parse(msg)
            
            controller = msg['controller']
            action = msg['action']
            params = msg['params']
            session_id = msg['session_id']
            
            log "[REQUEST] - [controller: #{controller}," + " action: #{action}, " + " params: #{params}]"
            
            if !params.nil?
              args = "params"
            else
              args = nil
            end
            
            # Metaprogramming code that will dyamically call the requested controller
            # and method
            result = nil
            eval %Q(
              session = get_session(session_id)
              
              if !session.nil?
                request = #{controller.camelize}Controller.new
                request.instance_variable_set(:@session, session)
                request.instance_variable_set(:@game_mq, @game_mq)
                request.extend(Broker::Commands)
                
                result = if args.nil?
                  request.#{action}
                else
                  request.#{action}(#{args})
                end
              else
                raise Interrupt
              end
            )
            respond_success(result)
          rescue ArgumentError
            respond_error(Errors::ERR_ARGUMENT_ERROR, $!)
          rescue Interrupt
            respond_error(Errors::ERR_INVALID_SESSION, $!)
          rescue
            respond_error(Errors::ERR_GENERIC, $!)
          ensure
            ActiveRecord::Base.connection.disconnect!
            #ActiveRecord::Base.verify_active_connections!
          end
          
          def respond_success(result)
            respond({ :result => result })
          end
          
          def respond_error(error, msg)
            respond({ :error => error, :error_msg => msg })
          end
          
          def respond(result)
            result.to_json
          end
          
          # Get the session id associated with the call
          def get_session(session_id)
            session = Session.find(:first, :conditions => ['session_id=?', session_id])
            return session
          end
          
          # Log the time and event
          def log(msg)
            Serv::Log.info(Time.now.to_s+': '+msg+"\n")
          end
          
        end
      end

      # Trap various signals that will stop XServ
      def trap_exit_signal(signal)
        trap(signal) {
          Serv::Initializer.stop!
        }
      end
    end
  end
  
  module Commands
    # Publish data to the game topic
    def gamex_publish(key, data)
      @game_mq.publish(data.to_json, { :key => key, :correlation_id => key })
      puts "[GAMEX_PUBLISH] - [key: #{key} data: #{data.to_s}]"
    end
    
    # Publish data to the user topic
    def user_publish(user_id, data)
      key = Broker::Base::USERS_TOPIC+'.'+user_id.to_s
      gamex_publish(key, data)
      puts "[USER_PUBLISH] - [user_id: #{user_id} data: #{data.to_s}]"
    end
  end
  
  module Errors
    ERR_TIMEOUT               = 1
    ERR_GENERIC               = 2
    ERR_ARGUMENT_ERROR        = 3
    ERR_INVALID_SESSION       = 4
  end
end
