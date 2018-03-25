
```ruby
require 'csv'
```

# CSV

This class provides a complete interface to CSV files and data. It
offers tools to enable you to read and write to and from Strings or IO
objects, as needed.

## Reading

### From a File

#### A Line at a Time


```ruby
CSV.foreach("path/to/file.csv") do |row|
  # use row here...
end
```

#### All at Once


```ruby
arr_of_arrs = CSV.read("path/to/file.csv")
```

### From a String

#### A Line at a Time


```ruby
CSV.parse("CSV,data,String") do |row|
  # use row here...
end
```

#### All at Once


```ruby
arr_of_arrs = CSV.parse("CSV,data,String")
```

## Writing

### To a File


```ruby
CSV.open("path/to/file.csv", "wb") do |csv|
  csv << ["row", "of", "CSV", "data"]
  csv << ["another", "row"]
  # ...
end
```

### To a String


```ruby
csv_string = CSV.generate do |csv|
  csv << ["row", "of", "CSV", "data"]
  csv << ["another", "row"]
  # ...
end
```

## Convert a Single Line


```ruby
csv_string = ["CSV", "data"].to_csv   # to CSV
csv_array  = "CSV,String".parse_csv   # from CSV
```

## Shortcut Interface


```ruby
CSV             { |csv_out| csv_out << %w{my data here} }  # to $stdout
CSV(csv = "")   { |csv_str| csv_str << %w{my data here} }  # to a String
CSV($stderr)    { |csv_err| csv_err << %w{my data here} }  # to $stderr
CSV($stdin)     { |csv_in|  csv_in.each { |row| p row } }  # from $stdin
```

## Advanced Usage

### Wrap an IO Object


```ruby
csv = CSV.new(io, options)
# ... read (with gets() or each()) from and write (with <<) to csv here ...
```

[CSV
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/csv/rdoc/CSV.html)

