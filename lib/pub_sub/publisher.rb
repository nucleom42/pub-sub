# frozen_string_literal: true

module PubSub
  module Publisher
    Error = Class.new(StandardError)

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def pub(event, args={})
        PubSub::Configuration.container.pub(event, args)
        true
      end
    end
  end
end 
