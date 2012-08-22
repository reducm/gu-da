require 'benchmark'
namespace :redis do
  desc "script about write redis to mysql"
  task :write_visit => [:environment]  do
    b = Benchmark.bm do |b|
      b.report do
        r = Redis.current
        keysarr = r.keys("article:*:visit_key")
        idsarr = keysarr.map{|a|a.split(":")[1]}
        sql = "update articles set visit=( case id "
        idsarr.each_with_index do |id|
          visit = r.get("article:#{id}:visit_key")
          sql << " when #{id} then #{visit} " 
        end
        sql << " end) where id in #{idsarr.inspect.sub("[","(").sub("]",")")} ;"
        puts "sql: ---\n #{sql} \n ---"
        puts ActiveRecord::Base.connection.execute(sql)
      end
    end
    Rails.logger.info b
  end
end

