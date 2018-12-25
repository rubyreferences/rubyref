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

### Reading[](#reading)

#### From a File[](#from-a-file)

##### A Line at a Time[](#a-line-at-a-time)


```ruby
CSV.foreach("path/to/file.csv") do |row|
  # use row here...
end
```

##### All at Once[](#all-at-once)


```ruby
arr_of_arrs = CSV.read("path/to/file.csv")
```

#### From a String[](#from-a-string)

##### A Line at a Time[](#a-line-at-a-time-1)


```ruby
CSV.parse("CSV,data,String") do |row|
  # use row here...
end
```

##### All at Once[](#all-at-once-1)


```ruby
arr_of_arrs = CSV.parse("CSV,data,String")
```

### Writing[](#writing)

#### To a File[](#to-a-file)


```ruby
CSV.open("path/to/file.csv", "wb") do |csv|
  csv << ["row", "of", "CSV", "data"]
  csv << ["another", "row"]
  # ...
end
```

#### To a String[](#to-a-string)


```ruby
csv_string = CSV.generate do |csv|
  csv << ["row", "of", "CSV", "data"]
  csv << ["another", "row"]
  # ...
end
```

### Convert a Single Line[](#convert-a-single-line)


```ruby
csv_string = ["CSV", "data"].to_csv   # to CSV
csv_array  = "CSV,String".parse_csv   # from CSV
```

### Shortcut Interface[](#shortcut-interface)


```ruby
CSV             { |csv_out| csv_out << %w{my data here} }  # to $stdout
CSV(csv = "")   { |csv_str| csv_str << %w{my data here} }  # to a String
CSV($stderr)    { |csv_err| csv_err << %w{my data here} }  # to $stderr
CSV($stdin)     { |csv_in|  csv_in.each { |row| p row } }  # from $stdin
```

### Advanced Usage[](#advanced-usage)

#### Wrap an IO Object[](#wrap-an-io-object)


```ruby
csv = CSV.new(io, options)
# ... read (with gets() or each()) from and write (with <<) to csv here ...
```

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/csv/rdoc/CSV.html'
class='ruby-doc remote' target='_blank'>CSV Reference</a>

