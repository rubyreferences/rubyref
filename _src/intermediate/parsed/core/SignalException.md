# SignalException

Raised when a signal is received.

    begin
      Process.kill('HUP',Process.pid)
      sleep # wait for receiver to handle signal sent by Process.kill
    rescue SignalException => e
      puts "received Exception #{e}"
    end

*produces:*

    received Exception SIGHUP

[SignalException Reference](https://ruby-doc.org/core-2.6/SignalException.html)
