
```ruby
require 'benchmark'
```

# Benchmark

The Benchmark module provides methods to measure and report the time
used to execute Ruby code.

* Measure the time to construct the string given by the expression
  `"a"*1_000_000_000`:   
  
  ```ruby
  require 'benchmark'
  
  puts Benchmark.measure { "a"*1_000_000_000 }
  ```
  
  On my machine (OSX 10.8.3 on i5 1.7 GHz) this generates:
  
  
  ```ruby
  0.350000   0.400000   0.750000 (  0.835234)
  ```
  
  This report shows the user CPU time, system CPU time, the sum of the
  user and system CPU times, and the elapsed real time. The unit of time
  is seconds.

* Do some experiments sequentially using the `#bm` method:
  
  
  ```ruby
  require 'benchmark'
  
  n = 5000000
  Benchmark.bm do |x|
    x.report { for i in 1..n; a = "1"; end }
    x.report { n.times do   ; a = "1"; end }
    x.report { 1.upto(n) do ; a = "1"; end }
  end
  ```
  
  The result:
  
  
  ```ruby
      user     system      total        real
  1.010000   0.000000   1.010000 (  1.014479)
  1.000000   0.000000   1.000000 (  0.998261)
  0.980000   0.000000   0.980000 (  0.981335)
  ```

* Continuing the previous example, put a label in each report:
  
  
  ```ruby
  require 'benchmark'
  
  n = 5000000
  Benchmark.bm(7) do |x|
    x.report("for:")   { for i in 1..n; a = "1"; end }
    x.report("times:") { n.times do   ; a = "1"; end }
    x.report("upto:")  { 1.upto(n) do ; a = "1"; end }
  end
  ```

The result:


```ruby
              user     system      total        real
for:      1.010000   0.000000   1.010000 (  1.015688)
times:    1.000000   0.000000   1.000000 (  1.003611)
upto:     1.030000   0.000000   1.030000 (  1.028098)
```

* The times for some benchmarks depend on the order in which items are
  run. These differences are due to the cost of memory allocation and
  garbage collection. To avoid these discrepancies, the #bmbm method is
  provided. For example, to compare ways to sort an array of floats:
  
  
  ```ruby
  require 'benchmark'
  
  array = (1..1000000).map { rand }
  
  Benchmark.bmbm do |x|
    x.report("sort!") { array.dup.sort! }
    x.report("sort")  { array.dup.sort  }
  end
  ```
  
  The result:
  
  
  ```ruby
  Rehearsal -----------------------------------------
  sort!   1.490000   0.010000   1.500000 (  1.490520)
  sort    1.460000   0.000000   1.460000 (  1.463025)
  -------------------------------- total: 2.960000sec
  
              user     system      total        real
  sort!   1.460000   0.000000   1.460000 (  1.460465)
  sort    1.450000   0.010000   1.460000 (  1.448327)
  ```

* Report statistics of sequential experiments with unique labels, using
  the #benchmark method:
  
  
  ```ruby
  require 'benchmark'
  include Benchmark         # we need the CAPTION and FORMAT constants
  
  n = 5000000
  Benchmark.benchmark(CAPTION, 7, FORMAT, ">total:", ">avg:") do |x|
    tf = x.report("for:")   { for i in 1..n; a = "1"; end }
    tt = x.report("times:") { n.times do   ; a = "1"; end }
    tu = x.report("upto:")  { 1.upto(n) do ; a = "1"; end }
    [tf+tt+tu, (tf+tt+tu)/3]
  end
  ```
  
  The result:
  
  
  ```ruby
               user     system      total        real
  for:      0.950000   0.000000   0.950000 (  0.952039)
  times:    0.980000   0.000000   0.980000 (  0.984938)
  upto:     0.950000   0.000000   0.950000 (  0.946787)
  >total:   2.880000   0.000000   2.880000 (  2.883764)
  >avg:     0.960000   0.000000   0.960000 (  0.961255)
  ```

[Benchmark
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/benchmark/rdoc/Benchmark.html)

