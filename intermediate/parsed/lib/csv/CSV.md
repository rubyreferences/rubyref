# CSV

This class provides a complete interface to CSV files and data.  It offers
tools to enable you to read and write to and from Strings or IO objects, as
needed.

## Reading

### From a File

#### A Line at a Time

    CSV.foreach("path/to/file.csv") do |row|
      # use row here...
    end

#### All at Once

    arr_of_arrs = CSV.read("path/to/file.csv")

### From a String

#### A Line at a Time

    CSV.parse("CSV,data,String") do |row|
      # use row here...
    end

#### All at Once

    arr_of_arrs = CSV.parse("CSV,data,String")

## Writing

### To a File

    CSV.open("path/to/file.csv", "wb") do |csv|
      csv << ["row", "of", "CSV", "data"]
      csv << ["another", "row"]
      # ...
    end

### To a String

    csv_string = CSV.generate do |csv|
      csv << ["row", "of", "CSV", "data"]
      csv << ["another", "row"]
      # ...
    end

## Convert a Single Line

    csv_string = ["CSV", "data"].to_csv   # to CSV
    csv_array  = "CSV,String".parse_csv   # from CSV

## Shortcut Interface

    CSV             { |csv_out| csv_out << %w{my data here} }  # to $stdout
    CSV(csv = "")   { |csv_str| csv_str << %w{my data here} }  # to a String
    CSV($stderr)    { |csv_err| csv_err << %w{my data here} }  # to $stderr
    CSV($stdin)     { |csv_in|  csv_in.each { |row| p row } }  # from $stdin

## Advanced Usage

### Wrap an IO Object

    csv = CSV.new(io, options)
    # ... read (with gets() or each()) from and write (with <<) to csv here ...

## CSV and Character Encodings (M17n or Multilingualization)

This new CSV parser is m17n savvy.  The parser works in the Encoding of the IO
or String object being read from or written to.  Your data is never transcoded
(unless you ask Ruby to transcode it for you) and will literally be parsed in
the Encoding it is in.  Thus CSV will return Arrays or Rows of Strings in the
Encoding of your data.  This is accomplished by transcoding the parser itself
into your Encoding.

Some transcoding must take place, of course, to accomplish this multiencoding
support.  For example, `:col_sep`, `:row_sep`, and `:quote_char` must be
transcoded to match your data.  Hopefully this makes the entire process feel
transparent, since CSV's defaults should just magically work for your data. 
However, you can set these values manually in the target Encoding to avoid the
translation.

It's also important to note that while all of CSV's core parser is now
Encoding agnostic, some features are not.  For example, the built-in
converters will try to transcode data to UTF-8 before making conversions.
Again, you can provide custom converters that are aware of your Encodings to
avoid this translation.  It's just too hard for me to support native
conversions in all of Ruby's Encodings.

Anyway, the practical side of this is simple:  make sure IO and String objects
passed into CSV have the proper Encoding set and everything should just work.
CSV methods that allow you to open IO objects (CSV::foreach(), CSV::open(),
CSV::read(), and CSV::readlines()) do allow you to specify the Encoding.

One minor exception comes when generating CSV into a String with an Encoding
that is not ASCII compatible.  There's no existing data for CSV to use to
prepare itself and thus you will probably need to manually specify the desired
Encoding for most of those cases.  It will try to guess using the fields in a
row of output though, when using CSV::generate_line() or Array#to_csv().

I try to point out any other Encoding issues in the documentation of methods
as they come up.

This has been tested to the best of my ability with all non-"dummy" Encodings
Ruby ships with.  However, it is brave new code and may have some bugs. Please
feel free to [report](mailto:james@grayproductions.net) any issues you find
with it.
