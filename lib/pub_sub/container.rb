# frozen_string_literal: true

module PubSub
  class Container

    def pub(*)
      raise NotImplementedError
    end
    
    def sub(*)
      raise NotImplementedError
    end
    
    def unsub(*)
      raise NotImplementedError
    end
    
    protected
    
    def retrieve_klasses(iterable)
      iterable.map{|clazz| clazz.split('::').inject(Object) {|o,c| o.const_get c}}
    end
    
    def fan_out(clazzes, args)
      mutex = Mutex.new
      
      mutex.synchronize do
        clazzes.each{ |clazz| clazz.call(args) }
        true
      end
    end
  end 
end

