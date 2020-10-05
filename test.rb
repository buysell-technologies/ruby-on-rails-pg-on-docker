require 'benchmark'

num_iteration = 10000

Benchmark.bm 10 do |r|
  r.report "no-index" do
    num_iteration.times do
      task = Task.find_by(title: "sample#{rand(1..1000)}")
    end
  end
end