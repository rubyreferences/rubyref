---
title: csv
prev: "/stdlib/formats.html"
next: "/stdlib/formats/json.html"
---


```ruby
require 'csv'
```

## CSV[](#csv)

This class provides a complete interface to CSV files and data. It
offers tools to enable you to read and write to and from Strings or IO
objects, as needed.

The most generic interface of the library is:


```ruby
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
```

There are several specialized class methods for one-statement reading or
writing, described in the Specialized Methods section.

If a String is passed into ::new, it is internally wrapped into a
StringIO object.

`options` can be used for specifying the particular CSV flavor (column
separators, row separators, value quoting and so on), and for data
conversion, see Data Conversion section for the description of the
latter.

### Specialized Methods[](#specialized-methods)

#### Reading[](#reading)


```ruby
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
```

#### Writing[](#writing)


```ruby
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
```

#### Shortcuts[](#shortcuts)


```ruby
# Core extensions for converting one line
csv_string = ["CSV", "data"].to_csv   # to CSV
csv_array  = "CSV,String".parse_csv   # from CSV

# CSV() method
CSV             { |csv_out| csv_out << %w{my data here} }  # to $stdout
CSV(csv = "")   { |csv_str| csv_str << %w{my data here} }  # to a String
CSV($stderr)    { |csv_err| csv_err << %w{my data here} }  # to $stderr
CSV($stdin)     { |csv_in|  csv_in.each { |row| p row } }  # from $stdin
```

### Data Conversion[](#data-conversion)

#### CSV with headers[](#csv-with-headers)

CSV allows to specify column names of CSV file, whether they are in
data, or provided separately. If headers specified, reading methods
return an instance of CSV::Table, consisting of CSV::Row.


```ruby
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
```

#### Typed data reading[](#typed-data-reading)

CSV allows to provide a set of data *converters* e.g. transformations to
try on input data. Converter could be a symbol from CSV::Converters
constant's keys, or lambda.


```ruby
# Without any converters:
CSV.parse('Bob,2018-03-01,100')
#=> [["Bob", "2018-03-01", "100"]]

# With built-in converters:
CSV.parse('Bob,2018-03-01,100', converters: %i[numeric date])
#=> [["Bob", #<Date: 2018-03-01>, 100]]

# With custom converters:
CSV.parse('Bob,2018-03-01,100', converters: [->(v) { Time.parse(v) rescue v }])
#=> [["Bob", 2018-03-01 00:00:00 +0200, "100"]]
```

<a href='https://ruby-doc.org/stdlib-2.6/libdoc/csv/rdoc/CSV.html'
class='ruby-doc remote' target='_blank'>CSV Reference</a>

