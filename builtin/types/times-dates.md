---
title: Times and Dates
prev: "/builtin/types/struct.html"
next: "/builtin/types/enumerable.html"
---

## Times and Dates[](#times-and-dates)



### Time[](#time)

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

#### Creating a new Time instance[](#creating-a-new-time-instance)

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
```

You can pass a UTC offset:


```ruby
Time.new(2002, 10, 31, 2, 2, 2, "+02:00") #=> 2002-10-31 02:02:02 +0200
```

Or a timezone object:


```ruby
tz = timezone("Europe/Athens") # Eastern European Time, UTC+2
Time.new(2002, 10, 31, 2, 2, 2, tz) #=> 2002-10-31 02:02:02 +0200
```

You can also use Time::gm, Time::local and Time::utc to infer GMT, local
and UTC timezones instead of using the current system setting.

You can also create a new time using Time::at which takes the number of
seconds (or fraction of seconds) since the <a
href='http://en.wikipedia.org/wiki/Unix_time' class='remote'
target='_blank'>Unix Epoch</a>.


```ruby
Time.at(628232400) #=> 1989-11-28 00:00:00 -0500
```

#### Working with an instance of Time[](#working-with-an-instance-of-time)

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

#### Timezone argument[](#timezone-argument)

<div class="since-version">Since Ruby 2.6</div>

A timezone argument must have `local_to_utc` and `utc_to_local` methods,
and may have `name`, `abbr`, and `dst?` methods.

The `local_to_utc` method should convert a Time-like object from the
timezone to UTC, and `utc_to_local` is the opposite. The result also
should be a Time or Time-like object (not necessary to be the same
class). The `#zone` of the result is just ignored. Time-like argument to
these methods is similar to a Time object in UTC without sub-second; it
has attribute readers for the parts, e.g. `#year`, `#month`, and so on,
and epoch time readers, `#to_i`. The sub-second attributes are fixed as
0, and `#utc_offset`, `#zone`, `#isdst`, and their aliases are same as a
Time object in UTC. Also `#to_time`, #+, and #- methods are defined.

The `name` method is used for marshaling. If this method is not defined
on a timezone object, Time objects using that timezone object can not be
dumped by Marshal.

The `abbr` method is used by '%Z' in `#strftime`.

The `dst?` method is called with a `Time` value and should return
whether the `Time` value is in daylight savings time in the zone.

##### Auto conversion to Timezone[](#auto-conversion-to-timezone)

At loading marshaled data, a timezone name will be converted to a
timezone object by `find_timezone` class method, if the method is
defined.

Similarly, that class method will be called when a timezone argument
does not have the necessary methods mentioned above.

<a href='https://ruby-doc.org/core-2.7.0/Time.html' class='ruby-doc
remote' target='_blank'>Time Reference</a>





#### time.rb[](#timerb)

Part of the useful functionality for `Time` is provided by the standard
library `time`.

Examples:


```ruby
require 'time'

t = Time.now
t.iso8601  # => "2011-10-05T22:26:12-04:00"
t.rfc2822  # => "Wed, 05 Oct 2011 22:26:12 -0400"
t.httpdate # => "Thu, 06 Oct 2011 02:26:12 GMT"

Time.parse("2010-10-31") #=> 2010-10-31 00:00:00 -0500
Time.strptime("2000-10-31", "%Y-%m-%d") #=> 2000-10-31 00:00:00 -0500
```

<a href='https://ruby-doc.org/stdlib-2.7.0/libdoc/time/rdoc/Time.html'
class='ruby-doc remote' target='_blank'>Time Reference</a>



#### Date[](#date)

*Part of standard library. You need to `require 'date'` before using.*

A subclass of Object that includes the Comparable module and easily
handles date.

A Date object is created with Date::new, Date::jd, Date::ordinal,
Date::commercial, Date::parse, Date::strptime, Date::today,
`Time#to_date`, etc.


```ruby
require 'date'

Date.new(2001,2,3)
 #=> #<Date: 2001-02-03 ...>
Date.jd(2451944)
 #=> #<Date: 2001-02-03 ...>
Date.ordinal(2001,34)
 #=> #<Date: 2001-02-03 ...>
Date.commercial(2001,5,6)
 #=> #<Date: 2001-02-03 ...>
Date.parse('2001-02-03')
 #=> #<Date: 2001-02-03 ...>
Date.strptime('03-02-2001', '%d-%m-%Y')
 #=> #<Date: 2001-02-03 ...>
Time.new(2001,2,3).to_date
 #=> #<Date: 2001-02-03 ...>
```

All date objects are immutable; hence cannot modify themselves.

The concept of a date object can be represented as a tuple of the day
count, the offset and the day of calendar reform.

The day count denotes the absolute position of a temporal dimension. The
offset is relative adjustment, which determines decoded local time with
the day count. The day of calendar reform denotes the start day of the
new style. The old style of the West is the Julian calendar which was
adopted by Caesar. The new style is the Gregorian calendar, which is the
current civil calendar of many countries.

The day count is virtually the astronomical Julian day number. The
offset in this class is usually zero, and cannot be specified directly.

A Date object can be created with an optional argument, the day of
calendar reform as a Julian day number, which should be 2298874 to
2426355 or negative/positive infinity. The default value is
`Date::ITALY` (2299161=1582-10-15). See also sample/cal.rb.


```
$ ruby sample/cal.rb -c it 10 1582
    October 1582
 S  M Tu  W Th  F  S
    1  2  3  4 15 16
17 18 19 20 21 22 23
24 25 26 27 28 29 30
31

$ ruby sample/cal.rb -c gb  9 1752
   September 1752
 S  M Tu  W Th  F  S
       1  2 14 15 16
17 18 19 20 21 22 23
24 25 26 27 28 29 30
```

A Date object has various methods. See each reference.


```ruby
d = Date.parse('3rd Feb 2001')
                             #=> #<Date: 2001-02-03 ...>
d.year                       #=> 2001
d.mon                        #=> 2
d.mday                       #=> 3
d.wday                       #=> 6
d += 1                       #=> #<Date: 2001-02-04 ...>
d.strftime('%a %d %b %Y')    #=> "Sun 04 Feb 2001"
```

<a href='https://ruby-doc.org/stdlib-2.7.0/libdoc/date/rdoc/Date.html'
class='ruby-doc remote' target='_blank'>Date Reference</a>



#### DateTime[](#datetime)

*Part of standard library. You need to `require 'date'` before using.*

A subclass of Date that easily handles date, hour, minute, second, and
offset.

DateTime does not consider any leap seconds, does not track any summer
time rules.

A DateTime object is created with DateTime::new, DateTime::jd,
DateTime::ordinal, DateTime::commercial, DateTime::parse,
DateTime::strptime, DateTime::now, `Time#to_datetime`, etc.


```ruby
require 'date'

DateTime.new(2001,2,3,4,5,6)
                    #=> #<DateTime: 2001-02-03T04:05:06+00:00 ...>
```

The last element of day, hour, minute, or second can be a fractional
number. The fractional number's precision is assumed at most nanosecond.


```ruby
DateTime.new(2001,2,3.5)
                    #=> #<DateTime: 2001-02-03T12:00:00+00:00 ...>
```

An optional argument, the offset, indicates the difference between the
local time and UTC. For example, `Rational(3,24)` represents ahead of 3
hours of UTC, `Rational(-5,24)` represents behind of 5 hours of UTC. The
offset should be -1 to +1, and its precision is assumed at most second.
The default value is zero (equals to UTC).


```ruby
DateTime.new(2001,2,3,4,5,6,Rational(3,24))
                    #=> #<DateTime: 2001-02-03T04:05:06+03:00 ...>
```

The offset also accepts string form:


```ruby
DateTime.new(2001,2,3,4,5,6,'+03:00')
                    #=> #<DateTime: 2001-02-03T04:05:06+03:00 ...>
```

An optional argument, the day of calendar reform (`start`), denotes a
Julian day number, which should be 2298874 to 2426355 or
negative/positive infinity. The default value is `Date::ITALY`
(2299161=1582-10-15).

A DateTime object has various methods. See each reference.


```ruby
d = DateTime.parse('3rd Feb 2001 04:05:06+03:30')
                    #=> #<DateTime: 2001-02-03T04:05:06+03:30 ...>
d.hour              #=> 4
d.min               #=> 5
d.sec               #=> 6
d.offset            #=> (7/48)
d.zone              #=> "+03:30"
d += Rational('1.5')
                    #=> #<DateTime: 2001-02-04%16:05:06+03:30 ...>
d = d.new_offset('+09:00')
                    #=> #<DateTime: 2001-02-04%21:35:06+09:00 ...>
d.strftime('%I:%M:%S %p')
                    #=> "09:35:06 PM"
d > DateTime.new(1999)
                    #=> true
```

##### When should you use DateTime and when should you use Time?[](#when-should-you-use-datetime-and-when-should-you-use-time)

It's a common misconception that <a
href='http://en.wikipedia.org/wiki/William_Shakespeare' class='remote'
target='_blank'>William Shakespeare</a> and <a
href='http://en.wikipedia.org/wiki/Miguel_de_Cervantes' class='remote'
target='_blank'>Miguel de Cervantes</a> died on the same day in history
- so much so that UNESCO named April 23 as <a
href='http://en.wikipedia.org/wiki/World_Book_Day' class='remote'
target='_blank'>World Book Day because of this fact</a>. However,
because England hadn't yet adopted the <a
href='http://en.wikipedia.org/wiki/Gregorian_calendar#Gregorian_reform'
class='remote' target='_blank'>Gregorian Calendar Reform</a> (and
wouldn't until <a
href='http://en.wikipedia.org/wiki/Calendar_(New_Style)_Act_1750'
class='remote' target='_blank'>1752</a>) their deaths are actually 10
days apart. Since Ruby's Time class implements a <a
href='http://en.wikipedia.org/wiki/Proleptic_Gregorian_calendar'
class='remote' target='_blank'>proleptic Gregorian calendar</a> and has
no concept of calendar reform there's no way to express this with Time
objects. This is where DateTime steps in:


```ruby
shakespeare = DateTime.iso8601('1616-04-23', Date::ENGLAND)
 #=> Tue, 23 Apr 1616 00:00:00 +0000
cervantes = DateTime.iso8601('1616-04-23', Date::ITALY)
 #=> Sat, 23 Apr 1616 00:00:00 +0000
```

Already you can see something is weird - the days of the week are
different. Taking this further:


```ruby
cervantes == shakespeare
 #=> false
(shakespeare - cervantes).to_i
 #=> 10
```

This shows that in fact they died 10 days apart (in reality 11 days
since Cervantes died a day earlier but was buried on the 23rd). We can
see the actual date of Shakespeare's death by using the `#gregorian`
method to convert it:


```ruby
shakespeare.gregorian
 #=> Tue, 03 May 1616 00:00:00 +0000
```

So there's an argument that all the celebrations that take place on the
23rd April in Stratford-upon-Avon are actually the wrong date since
England is now using the Gregorian calendar. You can see why when we
transition across the reform date boundary:


```ruby
# start off with the anniversary of Shakespeare's birth in 1751
shakespeare = DateTime.iso8601('1751-04-23', Date::ENGLAND)
 #=> Tue, 23 Apr 1751 00:00:00 +0000

# add 366 days since 1752 is a leap year and April 23 is after February 29
shakespeare + 366
 #=> Thu, 23 Apr 1752 00:00:00 +0000

# add another 365 days to take us to the anniversary in 1753
shakespeare + 366 + 365
 #=> Fri, 04 May 1753 00:00:00 +0000
```

As you can see, if we're accurately tracking the number of <a
href='http://en.wikipedia.org/wiki/Tropical_year' class='remote'
target='_blank'>solar years</a> since Shakespeare's birthday then the
correct anniversary date would be the 4th May and not the 23rd April.

So when should you use DateTime in Ruby and when should you use Time?
Almost certainly you'll want to use Time since your app is probably
dealing with current dates and times. However, if you need to deal with
dates and times in a historical context you'll want to use DateTime to
avoid making the same mistakes as UNESCO. If you also have to deal with
timezones then best of luck - just bear in mind that you'll probably be
dealing with <a href='http://en.wikipedia.org/wiki/Solar_time'
class='remote' target='_blank'>local solar times</a>, since it wasn't
until the 19th century that the introduction of the railways
necessitated the need for <a
href='http://en.wikipedia.org/wiki/Standard_time#Great_Britain'
class='remote' target='_blank'>Standard Time</a> and eventually
timezones.

<a
href='https://ruby-doc.org/stdlib-2.7.0/libdoc/date/rdoc/DateTime.html'
class='ruby-doc remote' target='_blank'>DateTime Reference</a>

