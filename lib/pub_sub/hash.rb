# frozen_string_literal: true
require 'set'

module PubSub
  class Hash < Container
    def initialize
      @container = {}
    end
    
    def pub(event, args={})
      iterable_subscriber_list = @container[event]
      return unless iterable_subscriber_list

      clazzes = retrieve_klasses(iterable_subscriber_list)
      fan_out(clazzes, args)
    end

    def sub(event, klazz_name)
      @container[event] = [].to_set unless @container[event]
      @container[event].add(klazz_name)
    end
  end
end
