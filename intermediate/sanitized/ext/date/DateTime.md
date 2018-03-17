# DateTime

## DateTime

A subclass of Date that easily handles date, hour, minute, second, and offset.

DateTime does not consider any leap seconds, does not track any summer time
rules.

A DateTime object is created with DateTime::new, DateTime::jd,
DateTime::ordinal, DateTime::commercial, DateTime::parse, DateTime::strptime,
DateTime::now, `Time#to_datetime`, etc.

    require 'date'

    DateTime.new(2001,2,3,4,5,6)
                        #=> #<DateTime: 2001-02-03T04:05:06+00:00 ...>

The last element of day, hour, minute, or second can be a fractional number.
The fractional number's precision is assumed at most nanosecond.

    DateTime.new(2001,2,3.5)
                        #=> #<DateTime: 2001-02-03T12:00:00+00:00 ...>

An optional argument, the offset, indicates the difference between the local
time and UTC. For example, `Rational(3,24)` represents ahead of 3 hours of
UTC, `Rational(-5,24)` represents behind of 5 hours of UTC. The offset should
be -1 to +1, and its precision is assumed at most second. The default value is
zero (equals to UTC).

    DateTime.new(2001,2,3,4,5,6,Rational(3,24))
                        #=> #<DateTime: 2001-02-03T04:05:06+03:00 ...>

The offset also accepts string form:

    DateTime.new(2001,2,3,4,5,6,'+03:00')
                        #=> #<DateTime: 2001-02-03T04:05:06+03:00 ...>

An optional argument, the day of calendar reform (`start`), denotes a Julian
day number, which should be 2298874 to 2426355 or negative/positive infinity.
The default value is `Date::ITALY` (2299161=1582-10-15).

A DateTime object has various methods. See each reference.

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

### When should you use DateTime and when should you use Time?

It's a common misconception that [William
Shakespeare](http://en.wikipedia.org/wiki/William_Shakespeare) and [Miguel de
Cervantes](http://en.wikipedia.org/wiki/Miguel_de_Cervantes) died on the same
day in history - so much so that UNESCO named April 23 as [World Book Day
because of this fact](http://en.wikipedia.org/wiki/World_Book_Day). However,
because England hadn't yet adopted the [Gregorian Calendar
Reform](http://en.wikipedia.org/wiki/Gregorian_calendar#Gregorian_reform) (and
wouldn't until
[1752](http://en.wikipedia.org/wiki/Calendar_(New_Style)_Act_1750)) their
deaths are actually 10 days apart. Since Ruby's Time class implements a
[proleptic Gregorian
calendar](http://en.wikipedia.org/wiki/Proleptic_Gregorian_calendar) and has
no concept of calendar reform there's no way to express this with Time
objects. This is where DateTime steps in:

    shakespeare = DateTime.iso8601('1616-04-23', Date::ENGLAND)
     #=> Tue, 23 Apr 1616 00:00:00 +0000
    cervantes = DateTime.iso8601('1616-04-23', Date::ITALY)
     #=> Sat, 23 Apr 1616 00:00:00 +0000

Already you can see something is weird - the days of the week are different.
Taking this further:

    cervantes == shakespeare
     #=> false
    (shakespeare - cervantes).to_i
     #=> 10

This shows that in fact they died 10 days apart (in reality 11 days since
Cervantes died a day earlier but was buried on the 23rd). We can see the
actual date of Shakespeare's death by using the `#gregorian` method to convert
it:

    shakespeare.gregorian
     #=> Tue, 03 May 1616 00:00:00 +0000

So there's an argument that all the celebrations that take place on the 23rd
April in Stratford-upon-Avon are actually the wrong date since England is now
using the Gregorian calendar. You can see why when we transition across the
reform date boundary:

    # start off with the anniversary of Shakespeare's birth in 1751
    shakespeare = DateTime.iso8601('1751-04-23', Date::ENGLAND)
     #=> Tue, 23 Apr 1751 00:00:00 +0000

    # add 366 days since 1752 is a leap year and April 23 is after February 29
    shakespeare + 366
     #=> Thu, 23 Apr 1752 00:00:00 +0000

    # add another 365 days to take us to the anniversary in 1753
    shakespeare + 366 + 365
     #=> Fri, 04 May 1753 00:00:00 +0000

As you can see, if we're accurately tracking the number of [solar
years](http://en.wikipedia.org/wiki/Tropical_year) since Shakespeare's
birthday then the correct anniversary date would be the 4th May and not the
23rd April.

So when should you use DateTime in Ruby and when should you use Time? Almost
certainly you'll want to use Time since your app is probably dealing with
current dates and times. However, if you need to deal with dates and times in
a historical context you'll want to use DateTime to avoid making the same
mistakes as UNESCO. If you also have to deal with timezones then best of luck
- just bear in mind that you'll probably be dealing with [local solar
times](http://en.wikipedia.org/wiki/Solar_time), since it wasn't until the
19th century that the introduction of the railways necessitated the need for
[Standard Time](http://en.wikipedia.org/wiki/Standard_time#Great_Britain) and
eventually timezones.