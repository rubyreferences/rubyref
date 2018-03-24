# Abbrev

Calculates the set of unambiguous abbreviations for a given set of
strings.


```ruby
require 'abbrev'
require 'pp'

pp Abbrev.abbrev(['ruby'])
#=>  {"ruby"=>"ruby", "rub"=>"ruby", "ru"=>"ruby", "r"=>"ruby"}

pp Abbrev.abbrev(%w{ ruby rules })
```

*Generates:*


```ruby
{ "ruby"  =>  "ruby",
  "rub"   =>  "ruby",
  "rules" =>  "rules",
  "rule"  =>  "rules",
  "rul"   =>  "rules" }
```

It also provides an array core extension, `Array#abbrev`.


```ruby
pp %w{ summer winter }.abbrev
```

*Generates:*


```ruby
{ "summer"  => "summer",
  "summe"   => "summer",
  "summ"    => "summer",
  "sum"     => "summer",
  "su"      => "summer",
  "s"       => "summer",
  "winter"  => "winter",
  "winte"   => "winter",
  "wint"    => "winter",
  "win"     => "winter",
  "wi"      => "winter",
  "w"       => "winter" }
```

[Abbrev
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/abbrev/rdoc/Abbrev.html)



## CMath

## Trigonometric and transcendental functions for complex numbers.

CMath is a library that provides trigonometric and transcendental
functions for complex numbers. The functions in this module accept
integers, floating-point numbers or complex numbers as arguments.

Note that the selection of functions is similar, but not identical, to
that in module math. The reason for having two modules is that some
users aren't interested in complex numbers, and perhaps don't even know
what they are. They would rather have Math.sqrt(-1) raise an exception
than return a complex number.

For more information you can see Complex class.

### Usage

To start using this library, simply require cmath library:


```ruby
require "cmath"
```

[CMath
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/cmath/rdoc/CMath.html)



## DBM

### Introduction

The DBM class provides a wrapper to a Unix-style
[dbm](http://en.wikipedia.org/wiki/Dbm) or Database Manager library.

Dbm databases do not have tables or columns; they are simple key-value
data stores, like a Ruby Hash except not resident in RAM. Keys and
values must be strings.

The exact library used depends on how Ruby was compiled. It could be any
of the following:

* The original ndbm library is released in 4.3BSD. It is based on dbm
  library in Unix Version 7 but has different API to support multiple
  databases in a process.

* [Berkeley DB](http://en.wikipedia.org/wiki/Berkeley_DB) versions 1
  thru 5, also known as BDB and Sleepycat DB, now owned by Oracle
  Corporation.

* Berkeley DB 1.x, still found in 4.4BSD derivatives (FreeBSD, OpenBSD,
  etc).

* [gdbm](http://www.gnu.org/software/gdbm/), the GNU implementation of
  dbm.
* [qdbm](http://fallabs.com/qdbm/index.html), another open source
  reimplementation of dbm.

All of these dbm implementations have their own Ruby interfaces
available, which provide richer (but varying) APIs.

### Cautions

Before you decide to use DBM, there are some issues you should consider:

* Each implementation of dbm has its own file format. Generally, dbm
  libraries will not read each other's files. This makes dbm files a bad
  choice for data exchange.

* Even running the same OS and the same dbm implementation, the database
  file format may depend on the CPU architecture. For example, files may
  not be portable between PowerPC and 386, or between 32 and 64 bit
  Linux.

* Different versions of Berkeley DB use different file formats. A change
  to the OS may therefore break DBM access to existing files.

* Data size limits vary between implementations. Original Berkeley DB
  was limited to 2GB of data. Dbm libraries also sometimes limit the
  total size of a key/value pair, and the total size of all the keys
  that hash to the same value. These limits can be as little as 512
  bytes. That said, gdbm and recent versions of Berkeley DB do away with
  these limits.

Given the above cautions, DBM is not a good choice for long term storage
of important data. It is probably best used as a fast and easy
alternative to a Hash for processing large amounts of data.

### Example


```ruby
require 'dbm'
db = DBM.open('rfcs', 0666, DBM::WRCREAT)
db['822'] = 'Standard for the Format of ARPA Internet Text Messages'
db['1123'] = 'Requirements for Internet Hosts - Application and Support'
db['3068'] = 'An Anycast Prefix for 6to4 Relay Routers'
puts db['822']
```

[DBM
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/dbm/rdoc/DBM.html)



## GDBM

### Summary

Ruby extension for GNU dbm (gdbm) -- a simple database engine for
storing key-value pairs on disk.

### Description

GNU dbm is a library for simple databases. A database is a file that
stores key-value pairs. Gdbm allows the user to store, retrieve, and
delete data by key. It furthermore allows a non-sorted traversal of all
key-value pairs. A gdbm database thus provides the same functionality as
a hash. As with objects of the Hash class, elements can be accessed with
`[]`. Furthermore, GDBM mixes in the Enumerable module, thus providing
convenient methods such as `#find`, `#collect`, `#map`, etc.

A process is allowed to open several different databases at the same
time. A process can open a database as a "reader" or a "writer". Whereas
a reader has only read-access to the database, a writer has read- and
write-access. A database can be accessed either by any number of readers
or by exactly one writer at the same time.

### Examples

1.  Opening/creating a database, and filling it with some entries:
    
    
    ```ruby
    require 'gdbm'
    
    gdbm = GDBM.new("fruitstore.db")
    gdbm["ananas"]    = "3"
    gdbm["banana"]    = "8"
    gdbm["cranberry"] = "4909"
    gdbm.close
    ```

2.  Reading out a database:
    
    
    ```ruby
    require 'gdbm'
    
    gdbm = GDBM.new("fruitstore.db")
    gdbm.each_pair do |key, value|
      print "#{key}: #{value}\n"
    end
    gdbm.close
    ```
    
    produces
    
    
    ```ruby
    banana: 8
    ananas: 3
    cranberry: 4909
    ```

### Links

* http://www.gnu.org/software/gdbm/

[GDBM
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/gdbm/rdoc/GDBM.html)



## NKF

NKF - Ruby extension for Network Kanji Filter

### Description

This is a Ruby Extension version of nkf (Network Kanji Filter). It
converts the first argument and returns converted result. Conversion
details are specified by flags as the first argument.

**Nkf** is a yet another kanji code converter among networks, hosts and
terminals. It converts input kanji code to designated kanji code such as
ISO-2022-JP, Shift\_JIS, EUC-JP, UTF-8 or UTF-16.

One of the most unique faculty of **nkf** is the guess of the input
kanji encodings. It currently recognizes ISO-2022-JP, Shift\_JIS,
EUC-JP, UTF-8 and UTF-16. So users needn't set the input kanji code
explicitly.

By default, X0201 kana is converted into X0208 kana. For X0201 kana,
SO/SI, SSO and ESC-(-I methods are supported. For automatic code
detection, nkf assumes no X0201 kana in Shift\_JIS. To accept X0201 in
Shift\_JIS, use **-X**, **-x** or **-S**.

### Flags

#### -b -u

Output is buffered (DEFAULT), Output is unbuffered.

#### -j -s -e -w -w16 -w32

Output code is ISO-2022-JP (7bit JIS), Shift\_JIS, EUC-JP, UTF-8N,
UTF-16BE, UTF-32BE. Without this option and compile option, ISO-2022-JP
is assumed.

#### -J -S -E -W -W16 -W32

Input assumption is JIS 7 bit, Shift\_JIS, EUC-JP, UTF-8, UTF-16,
UTF-32.

##### -J

Assume JIS input. It also accepts EUC-JP. This is the default. This flag
does not exclude Shift\_JIS.

##### -S

Assume Shift\_JIS and X0201 kana input. It also accepts JIS. EUC-JP is
recognized as X0201 kana. Without **-x** flag, X0201 kana (halfwidth
kana) is converted into X0208.

##### -E

Assume EUC-JP input. It also accepts JIS. Same as -J.

#### -t

No conversion.

#### -i\_

Output sequence to designate JIS-kanji. (DEFAULT B)

#### -o\_

Output sequence to designate ASCII. (DEFAULT B)

#### -r

\{de/en}crypt ROT13/47

#### -[h](123) --hiragana --katakana --katakana-hiragana

* -h1 --hiragana: Katakana to Hiragana conversion.

* -h2 --katakana: Hiragana to Katakana conversion.

* -h3 --katakana-hiragana: Katakana to Hiragana and Hiragana to Katakana
  conversion.

#### -T

Text mode output (MS-DOS)

#### -l

ISO8859-1 (Latin-1) support

#### -f\[`m` \[- `n`\]\]

Folding on `m` length with `n` margin in a line. Without this option,
fold length is 60 and fold margin is 10.

#### -F

New line preserving line folding.

#### -[Z](0-3)

Convert X0208 alphabet (Fullwidth Alphabets) to ASCII.

* -Z -Z0: Convert X0208 alphabet to ASCII.

* -Z1: Converts X0208 kankaku to single ASCII space.

* -Z2: Converts X0208 kankaku to double ASCII spaces.

* -Z3: Replacing Fullwidth >, <, ", & into '&gt;', '&lt;', '"', '&amp;'
  as in HTML.

#### -X -x

Assume X0201 kana in MS-Kanji. With **-X** or without this option, X0201
is converted into X0208 Kana. With **-x**, try to preserve X0208 kana
and do not convert X0201 kana to X0208. In JIS output, ESC-(-I is used.
In EUC output, SSO is used.

#### -[B](0-2)

Assume broken JIS-Kanji input, which lost ESC. Useful when your site is
using old B-News Nihongo patch.

* -B1: allows any char after ESC-( or ESC-$.

* -B2: forces ASCII after NL.

#### -I

Replacing non iso-2022-jp char into a geta character (substitute
character in Japanese).

#### -d -c

Delete r in line feed, Add r in line feed.

#### -[m](BQN0)

MIME ISO-2022-JP/ISO8859-1 decode. (DEFAULT) To see ISO8859-1 (Latin-1)
-l is necessary.

* -mB: Decode MIME base64 encoded stream. Remove header or other part
  before

conversion.

* -mQ: Decode MIME quoted stream. '\_' in quoted stream is converted to
  space.

* -mN: Non-strict decoding.

It allows line break in the middle of the base64 encoding.

* -m0: No MIME decode.

#### -M

MIME encode. Header style. All ASCII code and control characters are
intact. Kanji conversion is performed before encoding, so this cannot be
used as a picture encoder.

* -MB: MIME encode Base64 stream.

* -MQ: Perfome quoted encoding.

#### -l

Input and output code is ISO8859-1 (Latin-1) and ISO-2022-JP. **-s**,
**-e** and **-x** are not compatible with this option.

#### -[L](uwm)

new line mode Without this option, nkf doesn't convert line breaks.

* -Lu: unix (LF)

* -Lw: windows (CRLF)

* -Lm: mac (CR)

#### --fj --unix --mac --msdos --windows

convert for these system

#### --jis --euc --sjis --mime --base64

convert for named code

#### --jis-input --euc-input --sjis-input --mime-input --base64-input

assume input system

#### --ic=`input codeset` --oc=`output codeset`

Set the input or output codeset. NKF supports following codesets and
those codeset name are case insensitive.

* ISO-2022-JP: a.k.a. RFC1468, 7bit JIS, JUNET

* EUC-JP (eucJP-nkf): a.k.a. AT&T JIS, Japanese EUC, UJIS

* eucJP-ascii: a.k.a. x-eucjp-open-19970715-ascii

* eucJP-ms: a.k.a. x-eucjp-open-19970715-ms

* CP51932: Microsoft Version of EUC-JP.

* Shift\_JIS: SJIS, MS-Kanji

* Windows-31J: a.k.a. CP932

* UTF-8: same as UTF-8N

* UTF-8N: UTF-8 without BOM

* UTF-8-BOM: UTF-8 with BOM

* UTF-16: same as UTF-16BE

* UTF-16BE: UTF-16 Big Endian without BOM

* UTF-16BE-BOM: UTF-16 Big Endian with BOM

* UTF-16LE: UTF-16 Little Endian without BOM

* UTF-16LE-BOM: UTF-16 Little Endian with BOM

* UTF-32: same as UTF-32BE

* UTF-32BE: UTF-32 Big Endian without BOM

* UTF-32BE-BOM: UTF-32 Big Endian with BOM

* UTF-32LE: UTF-32 Little Endian without BOM

* UTF-32LE-BOM: UTF-32 Little Endian with BOM

* UTF8-MAC: NKDed UTF-8, a.k.a. UTF8-NFD (input only)

#### --fb-\{skip, html, xml, perl, java, subchar}

Specify the way that nkf handles unassigned characters. Without this
option, --fb-skip is assumed.

#### --prefix= `escape character` `target character` ..

When nkf converts to Shift\_JIS, nkf adds a specified escape character
to specified 2nd byte of Shift\_JIS characters. 1st byte of argument is
the escape character and following bytes are target characters.

#### --no-cp932ext

Handle the characters extended in CP932 as unassigned characters.

### --no-best-fit-chars

When Unicode to Encoded byte conversion, don't convert characters which
is not round trip safe. When Unicode to Unicode conversion, with this
and -x option, nkf can be used as UTF converter. (In other words,
without this and -x option, nkf doesn't save some characters)

When nkf convert string which related to path, you should use this
opion.

#### --cap-input

Decode hex encoded characters.

#### --url-input

Unescape percent escaped characters.

#### --

Ignore rest of -option.

[NKF
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/nkf/rdoc/NKF.html)



## SDBM

SDBM provides a simple file-based key-value store, which can only store
String keys and values.

Note that Ruby comes with the source code for SDBM, while the DBM and
GDBM standard libraries rely on external libraries and headers.

#### Examples

Insert values:


```ruby
require 'sdbm'

SDBM.open 'my_database' do |db|
  db['apple'] = 'fruit'
  db['pear'] = 'fruit'
  db['carrot'] = 'vegetable'
  db['tomato'] = 'vegetable'
end
```

Bulk update:


```ruby
require 'sdbm'

SDBM.open 'my_database' do |db|
  db.update('peach' => 'fruit', 'tomato' => 'fruit')
end
```

Retrieve values:


```ruby
require 'sdbm'

SDBM.open 'my_database' do |db|
  db.each do |key, value|
    puts "Key: #{key}, Value: #{value}"
  end
end
```

Outputs:


```ruby
Key: apple, Value: fruit
Key: pear, Value: fruit
Key: carrot, Value: vegetable
Key: peach, Value: fruit
Key: tomato, Value: fruit
```

[SDBM
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/sdbm/rdoc/SDBM.html)



## GetoptLong

The GetoptLong class allows you to parse command line options similarly
to the GNU getopt\_long() C library call. Note, however, that GetoptLong
is a pure Ruby implementation.

GetoptLong allows for POSIX-style options like `--file` as well as
single letter options like `-f`

The empty option `--` (two minus symbols) is used to end option
processing. This can be particularly important if options have optional
arguments.

Here is a simple example of usage:


```ruby
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
```

Example command line:


```ruby
hello -n 6 --name -- /tmp
```

[GetoptLong
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/getoptlong/rdoc/GetoptLong.html)



## DRb

### Overview

dRuby is a distributed object system for Ruby. It is written in pure
Ruby and uses its own protocol. No add-in services are needed beyond
those provided by the Ruby runtime, such as TCP sockets. It does not
rely on or interoperate with other distributed object systems such as
CORBA, RMI, or .NET.

dRuby allows methods to be called in one Ruby process upon a Ruby object
located in another Ruby process, even on another machine. References to
objects can be passed between processes. Method arguments and return
values are dumped and loaded in marshalled format. All of this is done
transparently to both the caller of the remote method and the object
that it is called upon.

An object in a remote process is locally represented by a DRb::DRbObject
instance. This acts as a sort of proxy for the remote object. Methods
called upon this DRbObject instance are forwarded to its remote object.
This is arranged dynamically at run time. There are no statically
declared interfaces for remote objects, such as CORBA's IDL.

dRuby calls made into a process are handled by a DRb::DRbServer instance
within that process. This reconstitutes the method call, invokes it upon
the specified local object, and returns the value to the remote caller.
Any object can receive calls over dRuby. There is no need to implement a
special interface, or mixin special functionality. Nor, in the general
case, does an object need to explicitly register itself with a DRbServer
in order to receive dRuby calls.

One process wishing to make dRuby calls upon another process must
somehow obtain an initial reference to an object in the remote process
by some means other than as the return value of a remote method call, as
there is initially no remote object reference it can invoke a method
upon. This is done by attaching to the server by URI. Each DRbServer
binds itself to a URI such as 'druby://example.com:8787'. A DRbServer
can have an object attached to it that acts as the server's **front**
**object**. A DRbObject can be explicitly created from the server's URI.
This DRbObject's remote object will be the server's front object. This
front object can then return references to other Ruby objects in the
DRbServer's process.

Method calls made over dRuby behave largely the same as normal Ruby
method calls made within a process. Method calls with blocks are
supported, as are raising exceptions. In addition to a method's standard
errors, a dRuby call may also raise one of the dRuby-specific errors,
all of which are subclasses of DRb::DRbError.

Any type of object can be passed as an argument to a dRuby call or
returned as its return value. By default, such objects are dumped or
marshalled at the local end, then loaded or unmarshalled at the remote
end. The remote end therefore receives a copy of the local object, not a
distributed reference to it; methods invoked upon this copy are executed
entirely in the remote process, not passed on to the local original.
This has semantics similar to pass-by-value.

However, if an object cannot be marshalled, a dRuby reference to it is
passed or returned instead. This will turn up at the remote end as a
DRbObject instance. All methods invoked upon this remote proxy are
forwarded to the local object, as described in the discussion of
DRbObjects. This has semantics similar to the normal Ruby
pass-by-reference.

The easiest way to signal that we want an otherwise marshallable object
to be passed or returned as a DRbObject reference, rather than
marshalled and sent as a copy, is to include the DRb::DRbUndumped mixin
module.

dRuby supports calling remote methods with blocks. As blocks (or rather
the Proc objects that represent them) are not marshallable, the block
executes in the local, not the remote, context. Each value yielded to
the block is passed from the remote object to the local block, then the
value returned by each block invocation is passed back to the remote
execution context to be collected, before the collected values are
finally returned to the local context as the return value of the method
invocation.

### Examples of usage

For more dRuby samples, see the `samples` directory in the full dRuby
distribution.

#### dRuby in client/server mode

This illustrates setting up a simple client-server drb system. Run the
server and client code in different terminals, starting the server code
first.

##### Server code


```ruby
require 'drb/drb'

# The URI for the server to connect to
URI="druby://localhost:8787"

class TimeServer

  def get_current_time
    return Time.now
  end

end

# The object that handles requests on the server
FRONT_OBJECT=TimeServer.new

$SAFE = 1   # disable eval() and friends

DRb.start_service(URI, FRONT_OBJECT)
# Wait for the drb server thread to finish before exiting.
DRb.thread.join
```

##### Client code


```ruby
require 'drb/drb'

# The URI to connect to
SERVER_URI="druby://localhost:8787"

# Start a local DRbServer to handle callbacks.
#
# Not necessary for this small example, but will be required
# as soon as we pass a non-marshallable object as an argument
# to a dRuby call.
#
# Note: this must be called at least once per process to take any effect.
# This is particularly important if your application forks.
DRb.start_service

timeserver = DRbObject.new_with_uri(SERVER_URI)
puts timeserver.get_current_time
```

#### Remote objects under dRuby

This example illustrates returning a reference to an object from a dRuby
call. The Logger instances live in the server process. References to
them are returned to the client process, where methods can be invoked
upon them. These methods are executed in the server process.

##### Server code


```ruby
require 'drb/drb'

URI="druby://localhost:8787"

class Logger

    # Make dRuby send Logger instances as dRuby references,
    # not copies.
    include DRb::DRbUndumped

    def initialize(n, fname)
        @name = n
        @filename = fname
    end

    def log(message)
        File.open(@filename, "a") do |f|
            f.puts("#{Time.now}: #{@name}: #{message}")
        end
    end

end

# We have a central object for creating and retrieving loggers.
# This retains a local reference to all loggers created.  This
# is so an existing logger can be looked up by name, but also
# to prevent loggers from being garbage collected.  A dRuby
# reference to an object is not sufficient to prevent it being
# garbage collected!
class LoggerFactory

    def initialize(bdir)
        @basedir = bdir
        @loggers = {}
    end

    def get_logger(name)
        if !@loggers.has_key? name
            # make the filename safe, then declare it to be so
            fname = name.gsub(/[.\/\\\:]/, "_").untaint
            @loggers[name] = Logger.new(name, @basedir + "/" + fname)
        end
        return @loggers[name]
    end

end

FRONT_OBJECT=LoggerFactory.new("/tmp/dlog")

$SAFE = 1   # disable eval() and friends

DRb.start_service(URI, FRONT_OBJECT)
DRb.thread.join
```

##### Client code


```ruby
require 'drb/drb'

SERVER_URI="druby://localhost:8787"

DRb.start_service

log_service=DRbObject.new_with_uri(SERVER_URI)

["loga", "logb", "logc"].each do |logname|

    logger=log_service.get_logger(logname)

    logger.log("Hello, world!")
    logger.log("Goodbye, world!")
    logger.log("=== EOT ===")

end
```

### Security

As with all network services, security needs to be considered when using
dRuby. By allowing external access to a Ruby object, you are not only
allowing outside clients to call the methods you have defined for that
object, but by default to execute arbitrary Ruby code on your server.
Consider the following:


```ruby
# !!! UNSAFE CODE !!!
ro = DRbObject::new_with_uri("druby://your.server.com:8989")
class << ro
  undef :instance_eval  # force call to be passed to remote object
end
ro.instance_eval("`rm -rf *`")
```

The dangers posed by instance\_eval and friends are such that a
DRbServer should generally be run with $SAFE set to at least level 1.
This will disable eval() and related calls on strings passed across the
wire. The sample usage code given above follows this practice.

A DRbServer can be configured with an access control list to selectively
allow or deny access from specified IP addresses. The main druby
distribution provides the ACL class for this purpose. In general, this
mechanism should only be used alongside, rather than as a replacement
for, a good firewall.

### dRuby internals

dRuby is implemented using three main components: a remote method call
marshaller/unmarshaller; a transport protocol; and an ID-to-object
mapper. The latter two can be directly, and the first indirectly,
replaced, in order to provide different behaviour and capabilities.

Marshalling and unmarshalling of remote method calls is performed by a
DRb::DRbMessage instance. This uses the Marshal module to dump the
method call before sending it over the transport layer, then
reconstitute it at the other end. There is normally no need to replace
this component, and no direct way is provided to do so. However, it is
possible to implement an alternative marshalling scheme as part of an
implementation of the transport layer.

The transport layer is responsible for opening client and server network
connections and forwarding dRuby request across them. Normally, it uses
DRb::DRbMessage internally to manage marshalling and unmarshalling. The
transport layer is managed by DRb::DRbProtocol. Multiple protocols can
be installed in DRbProtocol at the one time; selection between them is
determined by the scheme of a dRuby URI. The default transport protocol
is selected by the scheme 'druby:', and implemented by
DRb::DRbTCPSocket. This uses plain TCP/IP sockets for communication. An
alternative protocol, using UNIX domain sockets, is implemented by
DRb::DRbUNIXSocket in the file drb/unix.rb, and selected by the scheme
'drbunix:'. A sample implementation over HTTP can be found in the
samples accompanying the main dRuby distribution.

The ID-to-object mapping component maps dRuby object ids to the objects
they refer to, and vice versa. The implementation to use can be
specified as part of a DRb::DRbServer's configuration. The default
implementation is provided by DRb::DRbIdConv. It uses an object's
ObjectSpace id as its dRuby id. This means that the dRuby reference to
that object only remains meaningful for the lifetime of the object's
process and the lifetime of the object within that process. A modified
implementation is provided by DRb::TimerIdConv in the file
drb/timeridconv.rb. This implementation retains a local reference to all
objects exported over dRuby for a configurable period of time
(defaulting to ten minutes), to prevent them being garbage-collected
within this time. Another sample implementation is provided in
sample/name.rb in the main dRuby distribution. This allows objects to
specify their own id or "name". A dRuby reference can be made persistent
across processes by having each process register an object using the
same dRuby name.

[DRb
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/drb/rdoc/DRb.html)



## Exception2MessageMapper

Helper module for easily defining exceptions with predefined messages.

### Usage

1\. class Foo extend Exception2MessageMapper def\_e2message
ExistingExceptionClass, "message..." def\_exception :NewExceptionClass,
"message..."\[, superclass\] ... end

2\. module Error extend Exception2MessageMapper def\_e2message
ExistingExceptionClass, "message..." def\_exception :NewExceptionClass,
"message..."\[, superclass\] ... end class Foo include Error ... end


```ruby
foo = Foo.new
foo.Fail ....
```

3\. module Error extend Exception2MessageMapper def\_e2message
ExistingExceptionClass, "message..." def\_exception :NewExceptionClass,
"message..."\[, superclass\] ... end class Foo extend
Exception2MessageMapper include Error ... end


```ruby
Foo.Fail NewExceptionClass, arg...
Foo.Fail ExistingExceptionClass, arg...
```

[Exception2MessageMapper
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/e2mmap/rdoc/Exception2MessageMapper.html)



## Rinda

A module to implement the Linda distributed computing paradigm in Ruby.

Rinda is part of DRb (dRuby).

### Example(s)

See the sample/drb/ directory in the Ruby distribution, from 1.8.2
onwards.

[Rinda
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/rinda/rdoc/Rinda.html)



## Resolv

Resolv is a thread-aware DNS resolver library written in Ruby. Resolv
can handle multiple DNS requests concurrently without blocking the
entire Ruby interpreter.

See also resolv-replace.rb to replace the libc resolver with Resolv.

Resolv can look up various DNS resources using the DNS module directly.

Examples:


```ruby
p Resolv.getaddress "www.ruby-lang.org"
p Resolv.getname "210.251.121.214"

Resolv::DNS.open do |dns|
  ress = dns.getresources "www.ruby-lang.org", Resolv::DNS::Resource::IN::A
  p ress.map(&:address)
  ress = dns.getresources "ruby-lang.org", Resolv::DNS::Resource::IN::MX
  p ress.map { |r| [r.exchange.to_s, r.preference] }
end
```

### Bugs

* NIS is not supported.
* /etc/nsswitch.conf is not supported.

[Resolv
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/resolv/rdoc/Resolv.html)



## Shellwords

### Manipulates strings like the UNIX Bourne shell

This module manipulates strings according to the word parsing rules of
the UNIX Bourne shell.

The shellwords() function was originally a port of shellwords.pl, but
modified to conform to the Shell & Utilities volume of the IEEE Std
1003.1-2008, 2016 Edition \[1\].

#### Usage

You can use Shellwords to parse a string into a Bourne shell friendly
Array.


```ruby
require 'shellwords'

argv = Shellwords.split('three blind "mice"')
argv #=> ["three", "blind", "mice"]
```

Once you've required Shellwords, you can use the `#split` alias
String#shellsplit.


```ruby
argv = "see how they run".shellsplit
argv #=> ["see", "how", "they", "run"]
```

Be careful you don't leave a quote unmatched.


```ruby
argv = "they all ran after the farmer's wife".shellsplit
     #=> ArgumentError: Unmatched double quote: ...
```

In this case, you might want to use Shellwords.escape, or its alias
String#shellescape.

This method will escape the String for you to safely use with a Bourne
shell.


```ruby
argv = Shellwords.escape("special's.txt")
argv #=> "special\\'s.txt"
system("cat " + argv)
```

Shellwords also comes with a core extension for Array,
`Array#shelljoin`.


```ruby
argv = %w{ls -lta lib}
system(argv.shelljoin)
```

You can use this method to create an escaped string out of an array of
tokens separated by a space. In this example we used the literal
shortcut for Array.new.

#### Authors

* Wakou Aoyama
* Akinori MUSHA [knu@iDaemons.org](mailto:knu@iDaemons.org)

#### Contact

* Akinori MUSHA [knu@iDaemons.org](mailto:knu@iDaemons.org) (current
  maintainer)

#### Resources

1: [IEEE Std 1003.1-2008, 2016 Edition, the Shell & Utilities
volume](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/contents.htm
l)

[Shellwords
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/shellwords/rdoc/Shellwords.html)



## ThreadsWait

This class watches for termination of multiple threads. Basic
functionality (wait until specified threads have terminated) can be
accessed through the class method ThreadsWait::all\_waits. Finer control
can be gained using instance methods.

Example:


```ruby
ThreadsWait.all_waits(thr1, thr2, ...) do |t|
  STDERR.puts "Thread #{t} has terminated."
end

th = ThreadsWait.new(thread1,...)
th.next_wait # next one to be done
```

[ThreadsWait
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/thwait/rdoc/ThreadsWait.html)



## TSort

TSort implements topological sorting using Tarjan's algorithm for
strongly connected components.

TSort is designed to be able to be used with any object which can be
interpreted as a directed graph.

TSort requires two methods to interpret an object as a graph,
tsort\_each\_node and tsort\_each\_child.

* tsort\_each\_node is used to iterate for all nodes over a graph.
* tsort\_each\_child is used to iterate for child nodes of a given node.

The equality of nodes are defined by eql? and hash since TSort uses Hash
internally.

### A Simple Example

The following example demonstrates how to mix the TSort module into an
existing class (in this case, Hash). Here, we're treating each key in
the hash as a node in the graph, and so we simply alias the required
`#tsort_each_node` method to Hash's `#each_key` method. For each key in
the hash, the associated value is an array of the node's child nodes.
This choice in turn leads to our implementation of the required
`#tsort_each_child` method, which fetches the array of child nodes and
then iterates over that array using the user-supplied block.


```ruby
require 'tsort'

class Hash
  include TSort
  alias tsort_each_node each_key
  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end

{1=>[2, 3], 2=>[3], 3=>[], 4=>[]}.tsort
#=> [3, 2, 1, 4]

{1=>[2], 2=>[3, 4], 3=>[2], 4=>[]}.strongly_connected_components
#=> [[4], [2, 3], [1]]
```

### A More Realistic Example

A very simple `make` like tool can be implemented as follows:


```ruby
require 'tsort'

class Make
  def initialize
    @dep = {}
    @dep.default = []
  end

  def rule(outputs, inputs=[], &block)
    triple = [outputs, inputs, block]
    outputs.each {|f| @dep[f] = [triple]}
    @dep[triple] = inputs
  end

  def build(target)
    each_strongly_connected_component_from(target) {|ns|
      if ns.length != 1
        fs = ns.delete_if {|n| Array === n}
        raise TSort::Cyclic.new("cyclic dependencies: #{fs.join ', '}")
      end
      n = ns.first
      if Array === n
        outputs, inputs, block = n
        inputs_time = inputs.map {|f| File.mtime f}.max
        begin
          outputs_time = outputs.map {|f| File.mtime f}.min
        rescue Errno::ENOENT
          outputs_time = nil
        end
        if outputs_time == nil ||
           inputs_time != nil && outputs_time <= inputs_time
          sleep 1 if inputs_time != nil && inputs_time.to_i == Time.now.to_i
          block.call
        end
      end
    }
  end

  def tsort_each_child(node, &block)
    @dep[node].each(&block)
  end
  include TSort
end

def command(arg)
  print arg, "\n"
  system arg
end

m = Make.new
m.rule(%w[t1]) { command 'date > t1' }
m.rule(%w[t2]) { command 'date > t2' }
m.rule(%w[t3]) { command 'date > t3' }
m.rule(%w[t4], %w[t1 t3]) { command 'cat t1 t3 > t4' }
m.rule(%w[t5], %w[t4 t2]) { command 'cat t4 t2 > t5' }
m.build('t5')
```

### Bugs

* 'tsort.rb' is wrong name because this library uses Tarjan's algorithm
  for strongly connected components. Although
  'strongly\_connected\_components.rb' is correct but too long.

### References


```ruby
1.  Tarjan, "Depth First Search and Linear Graph Algorithms",
```

*SIAM Journal on Computing*, Vol. 1, No. 2, pp. 146-160, June 1972.

[TSort
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/tsort/rdoc/TSort.html)



## WeakRef

Weak Reference class that allows a referenced object to be
garbage-collected.

A WeakRef may be used exactly like the object it references.

Usage:


```ruby
foo = Object.new            # create a new object instance
p foo.to_s                  # original's class
foo = WeakRef.new(foo)      # reassign foo with WeakRef instance
p foo.to_s                  # should be same class
GC.start                    # start the garbage collector
p foo.to_s                  # should raise exception (recycled)
```

[WeakRef
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/weakref/rdoc/WeakRef.html)



## PStore

PStore implements a file based persistence mechanism based on a Hash.
User code can store hierarchies of Ruby objects (values) into the data
store file by name (keys). An object hierarchy may be just a single
object. User code may later read values back from the data store or even
update data, as needed.

The transactional behavior ensures that any changes succeed or fail
together. This can be used to ensure that the data store is not left in
a transitory state, where some values were updated but others were not.

Behind the scenes, Ruby objects are stored to the data store file with
Marshal. That carries the usual limitations. Proc objects cannot be
marshalled, for example.

### Usage example:


```ruby
require "pstore"

# a mock wiki object...
class WikiPage
  def initialize( page_name, author, contents )
    @page_name = page_name
    @revisions = Array.new

    add_revision(author, contents)
  end

  attr_reader :page_name

  def add_revision( author, contents )
    @revisions << { :created  => Time.now,
                    :author   => author,
                    :contents => contents }
  end

  def wiki_page_references
    [@page_name] + @revisions.last[:contents].scan(/\b(?:[A-Z]+[a-z]+){2,}/)
  end

  # ...
end

# create a new page...
home_page = WikiPage.new( "HomePage", "James Edward Gray II",
                          "A page about the JoysOfDocumentation..." )

# then we want to update page data and the index together, or not at all...
wiki = PStore.new("wiki_pages.pstore")
wiki.transaction do  # begin transaction; do all of this or none of it
  # store page...
  wiki[home_page.page_name] = home_page
  # ensure that an index has been created...
  wiki[:wiki_index] ||= Array.new
  # update wiki index...
  wiki[:wiki_index].push(*home_page.wiki_page_references)
end                   # commit changes to wiki data store file

### Some time later... ###

# read wiki data...
wiki.transaction(true) do  # begin read-only transaction, no changes allowed
  wiki.roots.each do |data_root_name|
    p data_root_name
    p wiki[data_root_name]
  end
end
```

### Transaction modes

By default, file integrity is only ensured as long as the operating
system (and the underlying hardware) doesn't raise any unexpected I/O
errors. If an I/O error occurs while PStore is writing to its file, then
the file will become corrupted.

You can prevent this by setting *pstore.ultra\_safe = true*. However,
this results in a minor performance loss, and only works on platforms
that support atomic file renames. Please consult the documentation for
`ultra_safe` for details.

Needless to say, if you're storing valuable data with PStore, then you
should backup the PStore files from time to time.

[PStore
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/pstore/rdoc/PStore.html)

