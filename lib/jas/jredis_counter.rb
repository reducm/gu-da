# encoding: UTF-8
module JCounter
  def self.included(receiver)
    if receiver.included_modules.map{|a|a.to_s}.grep(/Redis::Objects::Counter.*/).size > 0
      class << receiver
        include JJCounter
      end
    end
  end

  module JJCounter
    def jcounter(method_symbol)
      self.send :counter,"#{method_symbol}_key".to_sym

      self.after_find do |model|
        begin
          value_db = model.send method_symbol
          redis_counter = model.send "#{method_symbol}_key".to_sym
          if value_db > redis_counter.value
            redis_counter.incr(value_db - redis_counter.value)
          end

          model.define_singleton_method "old_#{method_symbol}".to_sym do
            value_db
          end

          model.define_singleton_method method_symbol do
            redis_counter.value
          end
        rescue Exception

        end
      end
    end
  end
end
