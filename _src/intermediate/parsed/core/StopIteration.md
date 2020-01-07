# StopIteration

Raised to stop the iteration, in particular by Enumerator#next. It is rescued
by Kernel#loop.

    loop do
      puts "Hello"
      raise StopIteration
      puts "World"
    end
    puts "Done!"

*produces:*

    Hello
    Done!

[StopIteration Reference](https://ruby-doc.org/core-2.7.0/StopIteration.html)
