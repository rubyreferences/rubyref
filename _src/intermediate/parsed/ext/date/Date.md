# Date

date and datetime class - Tadayoshi Funaba 1998-2011

'date' provides two classes: Date and DateTime.

## Terms and Definitions

Some terms and definitions are based on ISO 8601 and JIS X 0301.

### Calendar Date

The calendar date is a particular day of a calendar year, identified by its
ordinal number within a calendar month within that year.

In those classes, this is so-called "civil".

### Ordinal Date

The ordinal date is a particular day of a calendar year identified by its
ordinal number within the year.

In those classes, this is so-called "ordinal".

### Week Date

The week date is a date identified by calendar week and day numbers.

The calendar week is a seven day period within a calendar year, starting on a
Monday and identified by its ordinal number within the year; the first
calendar week of the year is the one that includes the first Thursday of that
year. In the Gregorian calendar, this is equivalent to the week which includes
January 4.

In those classes, this is so-called "commercial".

### Julian Day Number

The Julian day number is in elapsed days since noon (Greenwich Mean Time) on
January 1, 4713 BCE (in the Julian calendar).

In this document, the astronomical Julian day number is the same as the
original Julian day number. And the chronological Julian day number is a
variation of the Julian day number. Its days begin at midnight on local time.

In this document, when the term "Julian day number" simply appears, it just
refers to "chronological Julian day number", not the original.

In those classes, those are so-called "ajd" and "jd".

### Modified Julian Day Number

The modified Julian day number is in elapsed days since midnight (Coordinated
Universal Time) on November 17, 1858 CE (in the Gregorian calendar).

In this document, the astronomical modified Julian day number is the same as
the original modified Julian day number. And the chronological modified Julian
day number is a variation of the modified Julian day number. Its days begin at
midnight on local time.

In this document, when the term "modified Julian day number" simply appears,
it just refers to "chronological modified Julian day number", not the
original.

In those classes, those are so-called "amjd" and "mjd".

## Date

A subclass of Object that includes the Comparable module and easily handles
date.

A Date object is created with Date::new, Date::jd, Date::ordinal,
Date::commercial, Date::parse, Date::strptime, Date::today, Time#to_date, etc.

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

All date objects are immutable; hence cannot modify themselves.

The concept of a date object can be represented as a tuple of the day count,
the offset and the day of calendar reform.

The day count denotes the absolute position of a temporal dimension. The
offset is relative adjustment, which determines decoded local time with the
day count. The day of calendar reform denotes the start day of the new style.
The old style of the West is the Julian calendar which was adopted by Caesar.
The new style is the Gregorian calendar, which is the current civil calendar
of many countries.

The day count is virtually the astronomical Julian day number. The offset in
this class is usually zero, and cannot be specified directly.

A Date object can be created with an optional argument, the day of calendar
reform as a Julian day number, which should be 2298874 to 2426355 or
negative/positive infinity. The default value is `Date::ITALY`
(2299161=1582-10-15). See also sample/cal.rb.

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

A Date object has various methods. See each reference.

    d = Date.parse('3rd Feb 2001')
                                 #=> #<Date: 2001-02-03 ...>
    d.year                       #=> 2001
    d.mon                        #=> 2
    d.mday                       #=> 3
    d.wday                       #=> 6
    d += 1                       #=> #<Date: 2001-02-04 ...>
    d.strftime('%a %d %b %Y')    #=> "Sun 04 Feb 2001"

[Date Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/date/rdoc/Date.html)
