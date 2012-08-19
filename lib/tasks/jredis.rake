require 'benchmark'
namespace :redis do
  desc "script about write redis to mysql"
  task :write_visit => [:environment]  do
    b = Benchmark.bm do |b|
      b.report do
        r = Redis.current
        keysarr = r.keys("article:*:visit_key")
        idsarr = keysarr.map{|a|a.split(":")[1]}
        idsarr.each_with_index do |id|
          a = Article.find(id)
          if a.old_visit < a.visit_key.value
            puts "article_id: #{a.id} --- visit_set_to : #{a.visit_key.value}" if a.update_attribute(:visit, a.visit_key.value)
          end
        end
      end
    end
    Rails.logger.info b
  end
end

