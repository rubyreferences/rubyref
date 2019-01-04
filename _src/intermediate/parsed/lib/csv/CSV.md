# CSV

This class provides a complete interface to CSV files and data.  It offers
tools to enable you to read and write to and from Strings or IO objects, as
needed.

The most generic interface of the library is:

    csv = CSV.new(string_or_io, **options)

    # Reading: IO object should be open for read
    csv.read # => array of rows
    # or
    csv.each do |row|
      # ...
    end
    # or
    row = csv.shift

    # Writing: IO object should be open for write
    csv << row

There are several specialized class methods for one-statement reading or
writing, described in the Specialized Methods section.

If a String is passed into ::new, it is internally wrapped into a StringIO
object.

`options` can be used for specifying the particular CSV flavor (column
separators, row separators, value quoting and so on), and for data conversion,
see Data Conversion section for the description of the latter.

## Specialized Methods

### Reading

    # From a file: all at once
    arr_of_rows = CSV.read("path/to/file.csv", **options)
    # iterator-style:
    CSV.foreach("path/to/file.csv", **options) do |row|
      # ...
    end

    # From a string
    arr_of_rows = CSV.parse("CSV,data,String", **options)
    # or
    CSV.parse("CSV,data,String", **options) do |row|
      # ...
    end

### Writing

    # To a file
    CSV.open("path/to/file.csv", "wb") do |csv|
      csv << ["row", "of", "CSV", "data"]
      csv << ["another", "row"]
      # ...
    end

    # To a String
    csv_string = CSV.generate do |csv|
      csv << ["row", "of", "CSV", "data"]
      csv << ["another", "row"]
      # ...
    end

### Shortcuts

    # Core extensions for converting one line
    csv_string = ["CSV", "data"].to_csv   # to CSV
    csv_array  = "CSV,String".parse_csv   # from CSV

    # CSV() method
    CSV             { |csv_out| csv_out << %w{my data here} }  # to $stdout
    CSV(csv = "")   { |csv_str| csv_str << %w{my data here} }  # to a String
    CSV($stderr)    { |csv_err| csv_err << %w{my data here} }  # to $stderr
    CSV($stdin)     { |csv_in|  csv_in.each { |row| p row } }  # from $stdin

## Data Conversion

### CSV with headers

CSV allows to specify column names of CSV file, whether they are in data, or
provided separately. If headers specified, reading methods return an instance
of CSV::Table, consisting of CSV::Row.

    # Headers are part of data
    data = CSV.parse(<<~ROWS, headers: true)
      Name,Department,Salary
      Bob,Engineering,1000
      Jane,Sales,2000
      John,Management,5000
    ROWS

    data.class      #=> CSV::Table
    data.first      #=> #<CSV::Row "Name":"Bob" "Department":"Engineering" "Salary":"1000">
    data.first.to_h #=> {"Name"=>"Bob", "Department"=>"Engineering", "Salary"=>"1000"}

    # Headers provided by developer
    data = CSV.parse('Bob,Engeneering,1000', headers: %i[name department salary])
    data.first      #=> #<CSV::Row name:"Bob" department:"Engineering" salary:"1000">

### Typed data reading

CSV allows to provide a set of data *converters* e.g. transformations to try
on input data. Converter could be a symbol from CSV::Converters constant's
keys, or lambda.

    # Without any converters:
    CSV.parse('Bob,2018-03-01,100')
    #=> [["Bob", "2018-03-01", "100"]]

    # With built-in converters:
    CSV.parse('Bob,2018-03-01,100', converters: %i[numeric date])
    #=> [["Bob", #<Date: 2018-03-01>, 100]]

    # With custom converters:
    CSV.parse('Bob,2018-03-01,100', converters: [->(v) { Time.parse(v) rescue v }])
    #=> [["Bob", 2018-03-01 00:00:00 +0200, "100"]]

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

[CSV Reference](https://ruby-doc.org/stdlib-2.6/libdoc/csv/rdoc/CSV.html)
