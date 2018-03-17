# OptionParser

## OptionParser

### Introduction

OptionParser is a class for command-line option analysis.  It is much more
advanced, yet also easier to use, than GetoptLong, and is a more Ruby-oriented
solution.

### Features

1.  The argument specification and the code to handle it are written in the
    same place.
2.  It can output an option summary; you don't need to maintain this string
    separately.
3.  Optional and mandatory arguments are specified very gracefully.
4.  Arguments can be automatically converted to a specified class.
5.  Arguments can be restricted to a certain set.


All of these features are demonstrated in the examples below.  See
#make_switch for full documentation.

### Minimal example

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

### Generating Help

OptionParser can be used to automatically generate help for the commands you
write:

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

### Required Arguments

For options that require an argument, option specification strings may include
an option name in all caps. If an option is used without the required
argument, an exception will be raised.
    require 'optparse'

    options = {}
    OptionParser.new do |parser|
      parser.on("-r", "--require LIBRARY",
                "Require the LIBRARY before executing your script") do |lib|
        puts "You required #{lib}!"
      end
    end.parse!

Used:

    bash-3.2$ ruby optparse-test.rb -r
    optparse-test.rb:9:in `<main>': missing argument: -r (OptionParser::MissingArgument)
    bash-3.2$ ruby optparse-test.rb -r my-library
    You required my-library!

### Type Coercion

OptionParser supports the ability to coerce command line arguments into
objects for us.

OptionParser comes with a few ready-to-use kinds of  type coercion. They are:

*   Date  -- Anything accepted by `Date.parse`
*   DateTime -- Anything accepted by `DateTime.parse`
*   Time -- Anything accepted by `Time.httpdate` or `Time.parse`
*   URI  -- Anything accepted by `URI.parse`
*   Shellwords -- Anything accepted by `Shellwords.shellwords`
*   String -- Any non-empty string
*   Integer -- Any integer. Will convert octal. (e.g. 124, -3, 040)
*   Float -- Any float. (e.g. 10, 3.14, -100E+13)
*   Numeric -- Any integer, float, or rational (1, 3.4, 1/3)
*   DecimalInteger -- Like `Integer`, but no octal format.
*   OctalInteger -- Like `Integer`, but no decimal format.
*   DecimalNumeric -- Decimal integer or float.
*   TrueClass --  Accepts '+, yes, true, -, no, false' and defaults as `true`
*   FalseClass -- Same as `TrueClass`, but defaults to `false`
*   Array -- Strings separated by ',' (e.g. 1,2,3)
*   Regexp -- Regular expressions. Also includes options.


We can also add our own coercions, which we will cover soon.

#### Using Built-in Conversions

As an example, the built-in `Time` conversion is used. The other built-in
conversions behave in the same way. OptionParser will attempt to parse the
argument as a `Time`. If it succeeds, that time will be passed to the handler
block. Otherwise, an exception will be raised.

    require 'optparse'
    require 'optparse/time'
    OptionParser.new do |parser|
      parser.on("-t", "--time [TIME]", Time, "Begin execution at given time") do |time|
        p time
      end
    end.parse!

Used:

    bash-3.2$ ruby optparse-test.rb  -t nonsense
    ... invalid argument: -t nonsense (OptionParser::InvalidArgument)
    from ... time.rb:5:in `block in <top (required)>'
    from optparse-test.rb:31:in `<main>'
    bash-3.2$ ruby optparse-test.rb  -t 10-11-12
    2010-11-12 00:00:00 -0500
    bash-3.2$ ruby optparse-test.rb  -t 9:30
    2014-08-13 09:30:00 -0400

#### Creating Custom Conversions

The `accept` method on OptionParser may be used to create converters. It
specifies which conversion block to call whenever a class is specified. The
example below uses it to fetch a `User` object before the `on` handler
receives it.

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

output:
    bash-3.2$ ruby optparse-test.rb --user 1
    #<struct User id=1, name="Sam">
    bash-3.2$ ruby optparse-test.rb --user 2
    #<struct User id=2, name="Gandalf">
    bash-3.2$ ruby optparse-test.rb --user 3
    optparse-test.rb:15:in `block in find_user': No User Found for id 3 (RuntimeError)

### Complete example

The following example is a complete Ruby program.  You can run it and see the
effect of specifying various options.  This is probably the best way to learn
the features of `optparse`.

    require 'optparse'
    require 'optparse/time'
    require 'ostruct'
    require 'pp'

    class OptparseExample
      Version = '1.0.0'

      CODES = %w[iso-2022-jp shift_jis euc-jp utf8 binary]
      CODE_ALIASES = { "jis" => "iso-2022-jp", "sjis" => "shift_jis" }

      class ScriptOptions
        attr_accessor :library, :inplace, :encoding, :transfer_type,
                      :verbose, :extension, :delay, :time, :record_separator,
                      :list

        def initialize
          self.library = []
          self.inplace = false
          self.encoding = "utf8"
          self.transfer_type = :auto
          self.verbose = false
        end

        def define_options(parser)
          parser.banner = "Usage: example.rb [options]"
          parser.separator ""
          parser.separator "Specific options:"

          # add additional options
          perform_inplace_option(parser)
          delay_execution_option(parser)
          execute_at_time_option(parser)
          specify_record_separator_option(parser)
          list_example_option(parser)
          specify_encoding_option(parser)
          optional_option_argument_with_keyword_completion_option(parser)
          boolean_verbose_option(parser)

          parser.separator ""
          parser.separator "Common options:"
          # No argument, shows at tail.  This will print an options summary.
          # Try it and see!
          parser.on_tail("-h", "--help", "Show this message") do
            puts parser
            exit
          end
          # Another typical switch to print the version.
          parser.on_tail("--version", "Show version") do
            puts Version
            exit
          end
        end

        def perform_inplace_option(parser)
          # Specifies an optional option argument
          parser.on("-i", "--inplace [EXTENSION]",
                    "Edit ARGV files in place",
                    "(make backup if EXTENSION supplied)") do |ext|
            self.inplace = true
            self.extension = ext || ''
            self.extension.sub!(/\A\.?(?=.)/, ".")  # Ensure extension begins with dot.
          end
        end

        def delay_execution_option(parser)
          # Cast 'delay' argument to a Float.
          parser.on("--delay N", Float, "Delay N seconds before executing") do |n|
            self.delay = n
          end
        end

        def execute_at_time_option(parser)
          # Cast 'time' argument to a Time object.
          parser.on("-t", "--time [TIME]", Time, "Begin execution at given time") do |time|
            self.time = time
          end
        end

        def specify_record_separator_option(parser)
          # Cast to octal integer.
          parser.on("-F", "--irs [OCTAL]", OptionParser::OctalInteger,
                    "Specify record separator (default \\0)") do |rs|
            self.record_separator = rs
          end
        end

        def list_example_option(parser)
          # List of arguments.
          parser.on("--list x,y,z", Array, "Example 'list' of arguments") do |list|
            self.list = list
          end
        end

        def specify_encoding_option(parser)
          # Keyword completion.  We are specifying a specific set of arguments (CODES
          # and CODE_ALIASES - notice the latter is a Hash), and the user may provide
          # the shortest unambiguous text.
          code_list = (CODE_ALIASES.keys + CODES).join(', ')
          parser.on("--code CODE", CODES, CODE_ALIASES, "Select encoding",
                    "(#{code_list})") do |encoding|
            self.encoding = encoding
          end
        end

        def optional_option_argument_with_keyword_completion_option(parser)
          # Optional '--type' option argument with keyword completion.
          parser.on("--type [TYPE]", [:text, :binary, :auto],
                    "Select transfer type (text, binary, auto)") do |t|
            self.transfer_type = t
          end
        end

        def boolean_verbose_option(parser)
          # Boolean switch.
          parser.on("-v", "--[no-]verbose", "Run verbosely") do |v|
            self.verbose = v
          end
        end
      end

      #
      # Return a structure describing the options.
      #
      def parse(args)
        # The options specified on the command line will be collected in
        # *options*.

        @options = ScriptOptions.new
        @args = OptionParser.new do |parser|
          @options.define_options(parser)
          parser.parse!(args)
        end
        @options
      end

      attr_reader :parser, :options
    end  # class OptparseExample

    example = OptparseExample.new
    options = example.parse(ARGV)
    pp options # example.options
    pp ARGV

### Shell Completion

For modern shells (e.g. bash, zsh, etc.), you can use shell completion for
command line options.

### Further documentation

The above examples should be enough to learn how to use this class.  If you
have any questions, file a ticket at http://bugs.ruby-lang.org.
