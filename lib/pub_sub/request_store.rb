# frozen_string_literal: true

require "request_store"

module PubSub
  class RequestStore < Container
    def initialize
      @container = ::RequestStore.store
    end

    def pub(event, args={})
      iterable_subscriber_list = @container[event].split(",")
      return false unless iterable_subscriber_list

      clazzes = retrieve_klasses(iterable_subscriber_list)
      fan_out(clazzes, args)
    end

    def sub(event, klazz_name)
      mutex = Mutex.new

      mutex.synchronize do
        @container[event] = "#{klazz_name}" unless @container[event]
        @container[event] =  "#{@container[event]},#{klazz_name}" unless @container[event].include?(klazz_name)
      end
      true
    end

    def unsub(event, klazz_name)
      mutex = Mutex.new

      mutex.synchronize do
        return false unless @container[event]

        @container[event] = @container[event].gsub(",#{klazz_name}", "")
        true
      end
    end
  end
end

