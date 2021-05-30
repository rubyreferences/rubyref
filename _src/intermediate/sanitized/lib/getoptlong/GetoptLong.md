# GetoptLong

The GetoptLong class allows you to parse command line options similarly to the
GNU getopt_long() C library call. Note, however, that GetoptLong is a pure
Ruby implementation.

GetoptLong allows for POSIX-style options like `--file` as well as single
letter options like `-f`

The empty option `--` (two minus symbols) is used to end option processing.
This can be particularly important if options have optional arguments.

Here is a simple example of usage:

    require 'getoptlong'

    opts = GetoptLong.new(
      [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
      [ '--repeat', '-n', GetoptLong::REQUIRED_ARGUMENT ],
      [ '--name', GetoptLong::OPTIONAL_ARGUMENT ]
    )

    dir = nil
    name = nil
    repetitions = 1
    opts.each do |opt, arg|
      case opt
        when '--help'
          puts <<-EOF
    hello [OPTION] ... DIR

    -h, --help:
       show help

    --repeat x, -n x:
       repeat x times

    --name [name]:
       greet user by name, if name not supplied default is John

    DIR: The directory in which to issue the greeting.
          EOF
        when '--repeat'
          repetitions = arg.to_i
        when '--name'
          if arg == ''
            name = 'John'
          else
            name = arg
          end
      end
    end

    if ARGV.length != 1
      puts "Missing dir argument (try --help)"
      exit 0
    end

    dir = ARGV.shift

    Dir.chdir(dir)
    for i in (1..repetitions)
      print "Hello"
      if name
        print ", #{name}"
      end
      puts
    end

Example command line:

    hello -n 6 --name -- /tmp

[GetoptLong Reference](https://ruby-doc.org/stdlib-2.7.0/libdoc/getoptlong/rdoc/GetoptLong.html)