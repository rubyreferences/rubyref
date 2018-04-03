# Time

# time.rb

When 'time' is required, Time is extended with additional methods for parsing
and converting Times.

## Features

This library extends the Time class with the following conversions between
date strings and Time objects:

*   date-time defined by [RFC 2822](http://www.ietf.org/rfc/rfc2822.txt)
*   HTTP-date defined by [RFC 2616](http://www.ietf.org/rfc/rfc2616.txt)
*   dateTime defined by XML Schema Part 2: Datatypes ([ISO
    8601](http://www.iso.org/iso/date_and_time_format))

*   various formats handled by Date._parse
*   custom formats handled by Date._strptime


## Examples

All examples assume you have loaded Time with:

    require 'time'

All of these examples were done using the EST timezone which is GMT-5.

### Converting to a String

    t = Time.now
    t.iso8601  # => "2011-10-05T22:26:12-04:00"
    t.rfc2822  # => "Wed, 05 Oct 2011 22:26:12 -0400"
    t.httpdate # => "Thu, 06 Oct 2011 02:26:12 GMT"

### Time.parse

`#parse` takes a string representation of a Time and attempts to parse it using
a heuristic.

    Time.parse("2010-10-31") #=> 2010-10-31 00:00:00 -0500

Any missing pieces of the date are inferred based on the current date.

    # assuming the current date is "2011-10-31"
    Time.parse("12:00") #=> 2011-10-31 12:00:00 -0500

We can change the date used to infer our missing elements by passing a second
object that responds to `#mon`, `#day` and `#year`, such as Date, Time or DateTime.
We can also use our own object.

    class MyDate
      attr_reader :mon, :day, :year

      def initialize(mon, day, year)
        @mon, @day, @year = mon, day, year
      end
    end

    d  = Date.parse("2010-10-28")
    t  = Time.parse("2010-10-29")
    dt = DateTime.parse("2010-10-30")
    md = MyDate.new(10,31,2010)

    Time.parse("12:00", d)  #=> 2010-10-28 12:00:00 -0500
    Time.parse("12:00", t)  #=> 2010-10-29 12:00:00 -0500
    Time.parse("12:00", dt) #=> 2010-10-30 12:00:00 -0500
    Time.parse("12:00", md) #=> 2010-10-31 12:00:00 -0500

`#parse` also accepts an optional block. You can use this block to specify how
to handle the year component of the date. This is specifically designed for
handling two digit years. For example, if you wanted to treat all two digit
years prior to 70 as the year 2000+ you could write this:

    Time.parse("01-10-31") {|year| year + (year < 70 ? 2000 : 1900)}
    #=> 2001-10-31 00:00:00 -0500
    Time.parse("70-10-31") {|year| year + (year < 70 ? 2000 : 1900)}
    #=> 1970-10-31 00:00:00 -0500

### Time.strptime

`#strptime` works similar to `parse` except that instead of using a heuristic to
detect the format of the input string, you provide a second argument that
describes the format of the string. For example:

    Time.strptime("2000-10-31", "%Y-%m-%d") #=> 2000-10-31 00:00:00 -0500

[Time Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/time/rdoc/Time.html)