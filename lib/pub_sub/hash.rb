# frozen_string_literal: true
require "request_store"

module PubSub
  class Hash < Container
    def initialize
      RequestStore.store[:hash] = {}
    end
    
    def pub(event, args={})
      iterable_subscriber_list = RequestStore.store[:hash][event]
      return false unless iterable_subscriber_list

      clazzes = retrieve_klasses(iterable_subscriber_list)
      fan_out(clazzes, args)
    end

    def sub(event, klazz_name)
      mutex = Mutex.new

      mutex.synchronize do
        RequestStore.store[:hash][event] = [] unless RequestStore.store[:hash][event]
        RequestStore.store[:hash][event] << klazz_name unless RequestStore.store[:hash][event].include?(klazz_name)
      end
      true
    end

    def unsub(event, klazz_name)
      mutex = Mutex.new

      mutex.synchronize do
        return false unless RequestStore.store[:hash][event]

        RequestStore.store[:hash][event].delete(klazz_name)
        true
      end
    end
  end
end
