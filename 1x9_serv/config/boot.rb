# Don't change this file!
# Configure your app in config/environment.rb

SERV_ROOT = File.expand_path(File.dirname(__FILE__) + '/..')

module Serv
  class << self
    def boot!
      load_vendor_libs
      load_dependencies
      load_environment
    end
    
    def load_vendor_libs
      Dir.entries("#{SERV_ROOT}/vendor").each do |vendor|
        vendor_lib = "#{SERV_ROOT}/vendor/#{vendor}/lib"
        if File.directory?(vendor_lib) && vendor != ".."
          $LOAD_PATH.unshift vendor_lib
        end
      end
    end
    
    def load_dependencies
      require 'rubygems'      
      require 'ruby-debug' if defined?(DEBUG)
      
      require 'daemons'
      require 'erb'
      require 'mq'
      require 'active_record'
      require 'json'
      require 'base64'
      require 'logger'
      
      require 'lib/log'
      require 'lib/broker'
    end
    
    def load_environment
      load("#{SERV_ROOT}/config/environment.rb")
    end
  end
end

Serv.boot!
