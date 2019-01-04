## time.rb

Part of the useful functionality for `Time` is provided by the standard library `time`.

Examples:

    require 'time'

    t = Time.now
    t.iso8601  # => "2011-10-05T22:26:12-04:00"
    t.rfc2822  # => "Wed, 05 Oct 2011 22:26:12 -0400"
    t.httpdate # => "Thu, 06 Oct 2011 02:26:12 GMT"

    Time.parse("2010-10-31") #=> 2010-10-31 00:00:00 -0500
    Time.strptime("2000-10-31", "%Y-%m-%d") #=> 2000-10-31 00:00:00 -0500

[Time Reference](https://ruby-doc.org/stdlib-2.6/libdoc/time/rdoc/Time.html)