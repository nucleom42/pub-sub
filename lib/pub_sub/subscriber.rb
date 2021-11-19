# frozen_string_literal: true

module PubSub
  module Subscriber
    Error = Class.new(StandardError)

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def sub(event)
        PubSub::Configuration.container.sub(event, self.name)
        true
      end
    end
  end
end
