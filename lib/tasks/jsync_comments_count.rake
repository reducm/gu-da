require 'benchmark'
namespace :redis do
  desc "sync_comments_count"
  task :sync_comments_count => [:environment]  do
     Benchmark.bm do |b|
      b.report do
        redis = Redis.current
        Article.select("id").all.each do |article|
          actual_count = article.comments.count
          if actual_count > 0
            redis.set(article.comments_count.key, actual_count)
            puts "article_#{article.id} sync comments_count: #{actual_count}"
          end
        end
      end
    end
  end
end

