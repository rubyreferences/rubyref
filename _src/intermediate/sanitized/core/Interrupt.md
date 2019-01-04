# Interrupt

Raised when the interrupt signal is received, typically because the user has
pressed Control-C (on most posix platforms). As such, it is a subclass of
`SignalException`.

    begin
      puts "Press ctrl-C when you get bored"
      loop {}
    rescue Interrupt => e
      puts "Note: You will typically use Signal.trap instead."
    end

*produces:*

    Press ctrl-C when you get bored

*then waits until it is interrupted with Control-C and then prints:*

    Note: You will typically use Signal.trap instead.

[Interrupt Reference](https://ruby-doc.org/core-2.6/Interrupt.html)