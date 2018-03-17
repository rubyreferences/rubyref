# Date

date and datetime class - Tadayoshi Funaba 1998-2011

'date' provides two classes: Date and DateTime.

## Terms and Definitions

Some terms and definitions are based on ISO 8601 and JIS X 0301.

### Calendar Date

The calendar date is a particular day of a calendar year, identified by
its ordinal number within a calendar month within that year.

In those classes, this is so-called "civil".

### Ordinal Date

The ordinal date is a particular day of a calendar year identified by
its ordinal number within the year.

In those classes, this is so-called "ordinal".

### Week Date

The week date is a date identified by calendar week and day numbers.

The calendar week is a seven day period within a calendar year, starting
on a Monday and identified by its ordinal number within the year; the
first calendar week of the year is the one that includes the first
Thursday of that year. In the Gregorian calendar, this is equivalent to
the week which includes January 4.

In those classes, this is so-called "commercial".

### Julian Day Number

The Julian day number is in elapsed days since noon (Greenwich Mean
Time) on January 1, 4713 BCE (in the Julian calendar).

In this document, the astronomical Julian day number is the same as the
original Julian day number. And the chronological Julian day number is a
variation of the Julian day number. Its days begin at midnight on local
time.

In this document, when the term "Julian day number" simply appears, it
just refers to "chronological Julian day number", not the original.

In those classes, those are so-called "ajd" and "jd".

### Modified Julian Day Number

The modified Julian day number is in elapsed days since midnight
(Coordinated Universal Time) on November 17, 1858 CE (in the Gregorian
calendar).

In this document, the astronomical modified Julian day number is the
same as the original modified Julian day number. And the chronological
modified Julian day number is a variation of the modified Julian day
number. Its days begin at midnight on local time.

In this document, when the term "modified Julian day number" simply
appears, it just refers to "chronological modified Julian day number",
not the original.

In those classes, those are so-called "amjd" and "mjd".

## Date

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


```ruby
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



## DateTime

### DateTime

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

#### When should you use DateTime and when should you use Time?

It's a common misconception that [William Shakespeare][1] and [Miguel de
Cervantes][2] died on the same day in history - so much so that UNESCO
named April 23 as [World Book Day because of this fact][3]. However,
because England hadn't yet adopted the [Gregorian Calendar Reform][4]
(and wouldn't until [1752][5]) their deaths are actually 10 days apart.
Since Ruby's Time class implements a [proleptic Gregorian calendar][6]
and has no concept of calendar reform there's no way to express this
with Time objects. This is where DateTime steps in:


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

As you can see, if we're accurately tracking the number of [solar
years][7] since Shakespeare's birthday then the correct anniversary date
would be the 4th May and not the 23rd April.

So when should you use DateTime in Ruby and when should you use Time?
Almost certainly you'll want to use Time since your app is probably
dealing with current dates and times. However, if you need to deal with
dates and times in a historical context you'll want to use DateTime to
avoid making the same mistakes as UNESCO. If you also have to deal with
timezones then best of luck - just bear in mind that you'll probably be
dealing with [local solar times][8], since it wasn't until the 19th
century that the introduction of the railways necessitated the need for
[Standard Time][9] and eventually timezones.



[1]: http://en.wikipedia.org/wiki/William_Shakespeare
[2]: http://en.wikipedia.org/wiki/Miguel_de_Cervantes
[3]: http://en.wikipedia.org/wiki/World_Book_Day
[4]: http://en.wikipedia.org/wiki/Gregorian_calendar#Gregorian_reform
[5]: http://en.wikipedia.org/wiki/Calendar_(New_Style)_Act_1750
[6]: http://en.wikipedia.org/wiki/Proleptic_Gregorian_calendar
[7]: http://en.wikipedia.org/wiki/Tropical_year
[8]: http://en.wikipedia.org/wiki/Solar_time
[9]: http://en.wikipedia.org/wiki/Standard_time#Great_Britain
