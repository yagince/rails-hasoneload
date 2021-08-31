namespace :bench do
  task :latest => :environment do
    require "benchmark"

    count = 10

    Benchmark.bmbm do |x|
      x.report("order")      { count.times{ User.all.includes(:latest_post_order).to_a } }
      x.report("not exists") { count.times{ User.all.includes(:latest_post_not_exists).to_a } }
      x.report("max")        { count.times{ User.all.includes(:latest_post_max).to_a } }
    end
  end
end
