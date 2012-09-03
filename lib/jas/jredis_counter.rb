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
          db_counter = model.send method_symbol
          redis_counter = model.send "#{method_symbol}_key".to_sym
          if db_counter > redis_counter.value
            redis_counter.incr(db_counter - redis_counter.value)
          end

          model.define_singleton_method "old_#{method_symbol}".to_sym do
            db_counter
          end

          model.define_singleton_method method_symbol do
            redis_counter.value
          end
        rescue Exception
          #没有redis，或者redis里面没有这个counter的key的情况,可以写进日志里头
        end
      end
    end
  end
end
