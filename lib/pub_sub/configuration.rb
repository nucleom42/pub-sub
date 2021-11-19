# frozen_string_literal: true
require 'singleton'

require 'pub_sub/container'
require 'pub_sub/hash'
require 'pub_sub/publisher'
require 'pub_sub/subscriber'

module PubSub
  class Configuration
    private_class_method :new
    attr_reader :container

    @@singleton__instance = nil
    @@singleton__mutex = Mutex.new

    class << self
      def this(container = ::PubSub::Hash)
        return @@singleton__instance if @@singleton__instance

        @@singleton__mutex.synchronize do
          return @@singleton__instance if @@singleton__instance

          @@singleton__instance = new(container)
        end
        @@singleton__instance
      end
      
      def container
        this.container
      end
    end

    private

    def initialize(container)
      @container = container.new
    end
  end
end

