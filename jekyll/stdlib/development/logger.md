---
title: logger
prev: "/stdlib/development/fiddle.html"
next: "/stdlib/development/pp.html"
---


```ruby
require 'logger'
```

# Logger

The Logger class provides a simple but sophisticated logging utility
that you can use to output messages.

The messages have associated levels, such as `INFO` or `ERROR` that
indicate their importance. You can then give the Logger a level, and
only messages at that level or higher will be printed.

The levels are:

* `UNKNOWN`: An unknown message that should always be logged.
* `FATAL`: An unhandleable error that results in a program crash.
* `ERROR`: A handleable error condition.
* `WARN`: A warning.
* `INFO`: Generic (useful) information about system operation.
* `DEBUG`: Low-level information for developers.

For instance, in a production system, you may have your Logger set to
`INFO` or even `WARN`. When you are developing the system, however, you
probably want to know about the program's internal state, and would set
the Logger to `DEBUG`.

**Note**\: Logger does not escape or sanitize any messages passed to it.
Developers should be aware of when potentially malicious data
(user-input) is passed to Logger, and manually escape the untrusted
data:


```ruby
logger.info("User-input: #{input.dump}")
logger.info("User-input: %p" % input)
```

You can use `#formatter=` for escaping all data.


```ruby
original_formatter = Logger::Formatter.new
logger.formatter = proc { |severity, datetime, progname, msg|
  original_formatter.call(severity, datetime, progname, msg.dump)
}
logger.info(input)
```

### Example

This creates a Logger that outputs to the standard output stream, with a
level of `WARN`: 

```ruby
require 'logger'

logger = Logger.new(STDOUT)
logger.level = Logger::WARN

logger.debug("Created logger")
logger.info("Program started")
logger.warn("Nothing to do!")

path = "a_non_existent_file"

begin
  File.foreach(path) do |line|
    unless line =~ /^(\w+) = (.*)$/
      logger.error("Line in wrong format: #{line.chomp}")
    end
  end
rescue => err
  logger.fatal("Caught exception; exiting")
  logger.fatal(err)
end
```

Because the Logger's level is set to `WARN`, only the warning, error,
and fatal messages are recorded. The debug and info messages are
silently discarded.

## Format

Log messages are rendered in the output stream in a certain format by
default. The default format and a sample are shown below:

Log format


```
SeverityID, [DateTime #pid] SeverityLabel -- ProgName: message
```

Log sample


```
I, [1999-03-03T02:34:24.895701 #19074]  INFO -- Main: info.
```

You may change the date and time format via `#datetime_format=`.


```ruby
logger.datetime_format = '%Y-%m-%d %H:%M:%S'
      # e.g. "2004-01-03 00:54:26"
```

or via the constructor.


```ruby
Logger.new(logdev, datetime_format: '%Y-%m-%d %H:%M:%S')
```

Or, you may change the overall format via the `#formatter=` method.


```ruby
logger.formatter = proc do |severity, datetime, progname, msg|
  "#{datetime}: #{msg}\n"
end
# e.g. "2005-09-22 08:51:08 +0900: hello world"
```

or via the constructor.


```ruby
Logger.new(logdev, formatter: proc {|severity, datetime, progname, msg|
  "#{datetime}: #{msg}\n"
})
```

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/logger/rdoc/Logger.html'
class='ruby-doc remote reference' target='_blank'>Logger Reference</a>

