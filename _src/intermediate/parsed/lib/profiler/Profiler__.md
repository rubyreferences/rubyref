# Profiler__

Profile provides a way to Profile your Ruby application.

Profiling your program is a way of determining which methods are called and
how long each method takes to complete.  This way you can detect which methods
are possible bottlenecks.

Profiling your program will slow down your execution time considerably, so
activate it only when you need it.  Don't confuse benchmarking with profiling.

There are two ways to activate Profiling:

## Command line

Run your Ruby script with `-rprofile`:

    ruby -rprofile example.rb

If you're profiling an executable in your `$PATH` you can use `ruby -S`:

    ruby -rprofile -S some_executable

## From code

Just require 'profile':

    require 'profile'

    def slow_method
      5000.times do
        9999999999999999*999999999
      end
    end

    def fast_method
      5000.times do
        9999999999999999+999999999
      end
    end

    slow_method
    fast_method

The output in both cases is a report when the execution is over:

    ruby -rprofile example.rb

      %   cumulative   self              self     total
     time   seconds   seconds    calls  ms/call  ms/call  name
     68.42     0.13      0.13        2    65.00    95.00  Integer#times
     15.79     0.16      0.03     5000     0.01     0.01  Fixnum#*
     15.79     0.19      0.03     5000     0.01     0.01  Fixnum#+
      0.00     0.19      0.00        2     0.00     0.00  IO#set_encoding
      0.00     0.19      0.00        1     0.00   100.00  Object#slow_method
      0.00     0.19      0.00        2     0.00     0.00  Module#method_added
      0.00     0.19      0.00        1     0.00    90.00  Object#fast_method
      0.00     0.19      0.00        1     0.00   190.00  #toplevel

[Profiler__ Reference](https://ruby-doc.org/stdlib-2.6/libdoc/profiler/rdoc/Profiler__.html)
