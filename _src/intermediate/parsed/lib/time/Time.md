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


[Time Reference](https://ruby-doc.org/stdlib-2.6/libdoc/time/rdoc/Time.html)
