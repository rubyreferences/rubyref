# Time

Time is an abstraction of dates and times. Time is stored internally as
the number of seconds with fraction since the *Epoch*, January 1, 1970
00:00 UTC. Also see the library module Date. The Time class treats GMT
(Greenwich Mean Time) and UTC (Coordinated Universal Time) as
equivalent. GMT is the older way of referring to these baseline times
but persists in the names of calls on POSIX systems.

All times may have fraction. Be aware of this fact when comparing times
with each other -- times that are apparently equal when displayed may be
different when compared.

Since Ruby 1.9.2, Time implementation uses a signed 63 bit integer,
Bignum or Rational. The integer is a number of nanoseconds since the
*Epoch* which can represent 1823-11-12 to 2116-02-20. When Bignum or
Rational is used (before 1823, after 2116, under nanosecond), Time works
slower as when integer is used.

# Examples

All of these examples were done using the EST timezone which is GMT-5.

## Creating a new Time instance

You can create a new instance of Time with Time::new. This will use the
current system time. Time::now is an alias for this. You can also pass
parts of the time to Time::new such as year, month, minute, etc. When
you want to construct a time this way you must pass at least a year. If
you pass the year with nothing else time will default to January 1 of
that year at 00:00:00 with the current system timezone. Here are some
examples:


```ruby
Time.new(2002)         #=> 2002-01-01 00:00:00 -0500
Time.new(2002, 10)     #=> 2002-10-01 00:00:00 -0500
Time.new(2002, 10, 31) #=> 2002-10-31 00:00:00 -0500
Time.new(2002, 10, 31, 2, 2, 2, "+02:00") #=> 2002-10-31 02:02:02 +0200
```

You can also use #gm, #local and #utc to infer GMT, local and UTC
timezones instead of using the current system setting.

You can also create a new time using Time::at which takes the number of
seconds (or fraction of seconds) since the [Unix Epoch][1].


```ruby
Time.at(628232400) #=> 1989-11-28 00:00:00 -0500
```

## Working with an instance of Time

Once you have an instance of Time there is a multitude of things you can
do with it. Below are some examples. For all of the following examples,
we will work on the assumption that you have done the following:


```ruby
t = Time.new(1993, 02, 24, 12, 0, 0, "+09:00")
```

Was that a monday?


```ruby
t.monday? #=> false
```

What year was that again?


```ruby
t.year #=> 1993
```

Was it daylight savings at the time?


```ruby
t.dst? #=> false
```

What's the day a year later?


```ruby
t + (60*60*24*365) #=> 1994-02-24 12:00:00 +0900
```

How many seconds was that since the Unix Epoch?


```ruby
t.to_i #=> 730522800
```

You can also do standard functions like compare two times.


```ruby
t1 = Time.new(2010)
t2 = Time.new(2011)

t1 == t2 #=> false
t1 == t1 #=> true
t1 <  t2 #=> true
t1 >  t2 #=> false

Time.new(2010,10,31).between?(t1, t2) #=> true
```



[1]: http://en.wikipedia.org/wiki/Unix_time


## Time

## time.rb

When 'time' is required, Time is extended with additional methods for
parsing and converting Times.

### Features

This library extends the Time class with the following conversions
between date strings and Time objects:

* date-time defined by [RFC 2822][1]

* HTTP-date defined by [RFC 2616][2]
* dateTime defined by XML Schema Part 2: Datatypes ([ISO 8601][3])

* various formats handled by Date.\_parse
* custom formats handled by Date.\_strptime

### Examples

All examples assume you have loaded Time with:


```ruby
require 'time'
```

All of these examples were done using the EST timezone which is GMT-5.

#### Converting to a String


```ruby
t = Time.now
t.iso8601  # => "2011-10-05T22:26:12-04:00"
t.rfc2822  # => "Wed, 05 Oct 2011 22:26:12 -0400"
t.httpdate # => "Thu, 06 Oct 2011 02:26:12 GMT"
```

#### Time.parse

\#parse takes a string representation of a Time and attempts to parse it
using a heuristic.


```ruby
Time.parse("2010-10-31") #=> 2010-10-31 00:00:00 -0500
```

Any missing pieces of the date are inferred based on the current date.


```ruby
# assuming the current date is "2011-10-31"
Time.parse("12:00") #=> 2011-10-31 12:00:00 -0500
```

We can change the date used to infer our missing elements by passing a
second object that responds to #mon, #day and #year, such as Date, Time
or DateTime. We can also use our own object.


```ruby
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
```

\#parse also accepts an optional block. You can use this block to specify
how to handle the year component of the date. This is specifically
designed for handling two digit years. For example, if you wanted to
treat all two digit years prior to 70 as the year 2000+ you could write
this:


```ruby
Time.parse("01-10-31") {|year| year + (year < 70 ? 2000 : 1900)}
#=> 2001-10-31 00:00:00 -0500
Time.parse("70-10-31") {|year| year + (year < 70 ? 2000 : 1900)}
#=> 1970-10-31 00:00:00 -0500
```

#### Time.strptime

\#strptime works similar to `parse` except that instead of using a
heuristic to detect the format of the input string, you provide a second
argument that describes the format of the string. For example:


```ruby
Time.strptime("2000-10-31", "%Y-%m-%d") #=> 2000-10-31 00:00:00 -0500
```



[1]: http://www.ietf.org/rfc/rfc2822.txt
[2]: http://www.ietf.org/rfc/rfc2616.txt
[3]: http://www.iso.org/iso/date_and_time_format
