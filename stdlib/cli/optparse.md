---
title: 'optparse: CLI arguments parser'
prev: "/stdlib/cli/open3.html"
next: "/stdlib/cli/pty.html"
---


```ruby
require 'optparse'
```

## OptionParser

OptionParser is a class for command-line option analysis. It is much
more advanced, yet also easier to use, than GetoptLong, and is a more
Ruby-oriented solution.

#### Features

1.  The argument specification and the code to handle it are written in
    the same place.
2.  It can output an option summary; you don't need to maintain this
    string separately.
3.  Optional and mandatory arguments are specified very gracefully.
4.  Arguments can be automatically converted to a specified class.
5.  Arguments can be restricted to a certain set.

All of these features are demonstrated in the examples below. See
`#make_switch` for full documentation.

#### Minimal example


```ruby
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!

p options
p ARGV
```

#### Generating Help

OptionParser can be used to automatically generate help for the commands
you write:


```ruby
require 'optparse'

Options = Struct.new(:name)

class Parser
  def self.parse(options)
    args = Options.new("world")

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: example.rb [options]"

      opts.on("-nNAME", "--name=NAME", "Name to say hello to") do |n|
        args.name = n
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    return args
  end
end
options = Parser.parse %w[--help]

#=>
   # Usage: example.rb [options]
   #     -n, --name=NAME                  Name to say hello to
   #     -h, --help                       Prints this help
```

#### Required Arguments

For options that require an argument, option specification strings may
include an option name in all caps. If an option is used without the
required argument, an exception will be raised. require 'optparse'


```ruby
options = {}
OptionParser.new do |parser|
  parser.on("-r", "--require LIBRARY",
            "Require the LIBRARY before executing your script") do |lib|
    puts "You required #{lib}!"
  end
end.parse!
```

Used:


```
bash-3.2$ ruby optparse-test.rb -r
optparse-test.rb:9:in `<main>': missing argument: -r (OptionParser::MissingArgument)
bash-3.2$ ruby optparse-test.rb -r my-library
You required my-library!
```

#### Type Coercion

OptionParser supports the ability to coerce command line arguments into
objects for us.

OptionParser comes with a few ready-to-use kinds of type coercion. They
are:

* Date -- Anything accepted by `Date.parse`
* DateTime -- Anything accepted by `DateTime.parse`
* Time -- Anything accepted by `Time.httpdate` or `Time.parse`
* URI -- Anything accepted by `URI.parse`
* Shellwords -- Anything accepted by `Shellwords.shellwords`
* String -- Any non-empty string
* Integer -- Any integer. Will convert octal. (e.g. 124, -3, 040)
* Float -- Any float. (e.g. 10, 3.14, -100E+13)
* Numeric -- Any integer, float, or rational (1, 3.4, 1/3)
* DecimalInteger -- Like `Integer`, but no octal format.
* OctalInteger -- Like `Integer`, but no decimal format.
* DecimalNumeric -- Decimal integer or float.
* TrueClass -- Accepts '+, yes, true, -, no, false' and defaults as
  `true`
* FalseClass -- Same as `TrueClass`, but defaults to `false`
* Array -- Strings separated by ',' (e.g. 1,2,3)
* Regexp -- Regular expressions. Also includes options.

We can also add our own coercions, which we will cover soon.

##### Using Built-in Conversions

As an example, the built-in `Time` conversion is used. The other
built-in conversions behave in the same way. OptionParser will attempt
to parse the argument as a `Time`. If it succeeds, that time will be
passed to the handler block. Otherwise, an exception will be raised.


```ruby
require 'optparse'
require 'optparse/time'
OptionParser.new do |parser|
  parser.on("-t", "--time [TIME]", Time, "Begin execution at given time") do |time|
    p time
  end
end.parse!
```

Used:


```
bash-3.2$ ruby optparse-test.rb  -t nonsense
... invalid argument: -t nonsense (OptionParser::InvalidArgument)
from ... time.rb:5:in `block in <top (required)>`
from optparse-test.rb:31:in `<main>'
bash-3.2$ ruby optparse-test.rb  -t 10-11-12
2010-11-12 00:00:00 -0500
bash-3.2$ ruby optparse-test.rb  -t 9:30
2014-08-13 09:30:00 -0400
```

##### Creating Custom Conversions

The `accept` method on OptionParser may be used to create converters. It
specifies which conversion block to call whenever a class is specified.
The example below uses it to fetch a `User` object before the `on`
handler receives it.


```ruby
require 'optparse'

User = Struct.new(:id, :name)

def find_user id
  not_found = ->{ raise "No User Found for id #{id}" }
  [ User.new(1, "Sam"),
    User.new(2, "Gandalf") ].find(not_found) do |u|
    u.id == id
  end
end

op = OptionParser.new
op.accept(User) do |user_id|
  find_user user_id.to_i
end

op.on("--user ID", User) do |user|
  puts user
end

op.parse!
```

output:


```
bash-3.2$ ruby optparse-test.rb --user 1
#<struct User id=1, name="Sam">
bash-3.2$ ruby optparse-test.rb --user 2
#<struct User id=2, name="Gandalf">
bash-3.2$ ruby optparse-test.rb --user 3
optparse-test.rb:15:in `block in find_user`: No User Found for id 3 (RuntimeError)
```

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/optparse/rdoc/OptionParser.html'
class='ruby-doc remote' target='_blank'>OptionParser Reference</a>

