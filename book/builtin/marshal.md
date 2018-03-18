# Marshal

The marshaling library converts collections of Ruby objects into a byte
stream, allowing them to be stored outside the currently active script.
This data may subsequently be read and the original objects
reconstituted.

Marshaled data has major and minor version numbers stored along with the
object information. In normal use, marshaling can only load data written
with the same major version number and an equal or lower minor version
number. If Ruby's \`\`verbose\`' flag is set (normally using -d, -v, -w,
or --verbose) the major and minor numbers must match exactly. Marshal
versioning is independent of Ruby's version numbers. You can extract the
version by reading the first two bytes of marshaled data.


```ruby
str = Marshal.dump("thing")
RUBY_VERSION   #=> "1.9.0"
str[0].ord     #=> 4
str[1].ord     #=> 8
```

Some objects cannot be dumped: if the objects to be dumped include
bindings, procedure or method objects, instances of class IO, or
singleton objects, a TypeError will be raised.

If your class has special serialization needs (for example, if you want
to serialize in some specific format), or if it contains objects that
would otherwise not be serializable, you can implement your own
serialization strategy.

There are two methods of doing this, your object can define either
marshal\_dump and marshal\_load or \_dump and \_load. marshal\_dump will
take precedence over \_dump if both are defined. marshal\_dump may
result in smaller Marshal strings.

## Security considerations

By design, Marshal.load can deserialize almost any class loaded into the
Ruby process. In many cases this can lead to remote code execution if
the Marshal data is loaded from an untrusted source.

As a result, Marshal.load is not suitable as a general purpose
serialization format and you should never unmarshal user supplied input
or other untrusted data.

If you need to deserialize untrusted data, use JSON or another
serialization format that is only able to load simple, 'primitive' types
such as String, Array, Hash, etc. Never allow user input to specify
arbitrary types to deserialize into.

## marshal\_dump and marshal\_load

When dumping an object the method marshal\_dump will be called.
marshal\_dump must return a result containing the information necessary
for marshal\_load to reconstitute the object. The result can be any
object.

When loading an object dumped using marshal\_dump the object is first
allocated then marshal\_load is called with the result from
marshal\_dump. marshal\_load must recreate the object from the
information in the result.

Example:


```ruby
class MyObj
  def initialize name, version, data
    @name    = name
    @version = version
    @data    = data
  end

  def marshal_dump
    [@name, @version]
  end

  def marshal_load array
    @name, @version = array
  end
end
```

## \_dump and \_load

Use \_dump and \_load when you need to allocate the object you're
restoring yourself.

When dumping an object the instance method \_dump is called with an
Integer which indicates the maximum depth of objects to dump (a value of
-1 implies that you should disable depth checking). \_dump must return a
String containing the information necessary to reconstitute the object.

The class method \_load should take a String and use it to return an
object of the same class.

Example:


```ruby
class MyObj
  def initialize name, version, data
    @name    = name
    @version = version
    @data    = data
  end

  def _dump level
    [@name, @version].join ':'
  end

  def self._load args
    new(*args.split(':'))
  end
end
```

Since Marshal.dump outputs a string you can have \_dump return a Marshal
string which is Marshal.loaded in \_load for complex objects.



## Marshal Format

The Marshal format is used to serialize ruby objects. The format can
store arbitrary objects through three user-defined extension mechanisms.

For documentation on using Marshal to serialize and deserialize objects,
see the Marshal module.

This document calls a serialized set of objects a stream. The Ruby
implementation can load a set of objects from a String, an IO or an
object that implements a `getc` method.

### Stream Format

The first two bytes of the stream contain the major and minor version,
each as a single byte encoding a digit. The version implemented in Ruby
is 4.8 (stored as "x04x08") and is supported by ruby 1.8.0 and newer.

Different major versions of the Marshal format are not compatible and
cannot be understood by other major versions. Lesser minor versions of
the format can be understood by newer minor versions. Format 4.7 can be
loaded by a 4.8 implementation but format 4.8 cannot be loaded by a 4.7
implementation.

Following the version bytes is a stream describing the serialized
object. The stream contains nested objects (the same as a Ruby object)
but objects in the stream do not necessarily have a direct mapping to
the Ruby object model.

Each object in the stream is described by a byte indicating its type
followed by one or more bytes describing the object. When "object" is
mentioned below it means any of the types below that defines a Ruby
object.

#### true, false, nil

These objects are each one byte long. "T" is represents `true`, "F"
represents `false` and "0" represents `nil`.

#### Fixnum and long

"i" represents a signed 32 bit value using a packed format. One through
five bytes follows the type. The value loaded will always be a Fixnum.
On 32 bit platforms (where the precision of a Fixnum is less than 32
bits) loading large values will cause overflow on CRuby.

The fixnum type is used to represent both ruby Fixnum objects and the
sizes of marshaled arrays, hashes, instance variables and other types.
In the following sections "long" will mean the format described below,
which supports full 32 bit precision.

The first byte has the following special values:

* "x00"\: The value of the integer is 0. No bytes follow.

* "x01"\: The total size of the integer is two bytes. The following byte
  is a positive integer in the range of 0 through 255. Only values
  between 123 and 255 should be represented this way to save bytes.

* "xff"\: The total size of the integer is two bytes. The following byte
  is a negative integer in the range of -1 through -256.

* "x02"\: The total size of the integer is three bytes. The following
  two bytes are a positive little-endian integer.

* "xfe"\: The total size of the integer is three bytes. The following
  two bytes are a negative little-endian integer.

* "x03"\: The total size of the integer is four bytes. The following
  three bytes are a positive little-endian integer.

* "xfd"\: The total size of the integer is two bytes. The following
  three bytes are a negative little-endian integer.

* "x04"\: The total size of the integer is five bytes. The following
  four bytes are a positive little-endian integer. For compatibility
  with 32 bit ruby, only Fixnums less than 1073741824 should be
  represented this way. For sizes of stream objects full precision may
  be used.

* "xfc"\: The total size of the integer is two bytes. The following four
  bytes are a negative little-endian integer. For compatibility with 32
  bit ruby, only Fixnums greater than -10737341824 should be represented
  this way. For sizes of stream objects full precision may be used.

Otherwise the first byte is a sign-extended eight-bit value with an
offset. If the value is positive the value is determined by subtracting
5 from the value. If the value is negative the value is determined by
adding 5 to the value.

There are multiple representations for many values. CRuby always outputs
the shortest representation possible.

#### Symbols and Byte Sequence

"\:" represents a real symbol. A real symbol contains the data needed to
define the symbol for the rest of the stream as future occurrences in
the stream will instead be references (a symbol link) to this one. The
reference is a zero-indexed 32 bit value (so the first occurrence of
`:hello` is 0).

Following the type byte is byte sequence which consists of a long
indicating the number of bytes in the sequence followed by that many
bytes of data. Byte sequences have no encoding.

For example, the following stream contains the Symbol `:hello`: 

```ruby
"\x04\x08:\x0ahello"
```

";" represents a Symbol link which references a previously defined
Symbol. Following the type byte is a long containing the index in the
lookup table for the linked (referenced) Symbol.

For example, the following stream contains `[:hello, :hello]`: 

```ruby
"\x04\b[\a:\nhello;\x00"
```

When a "symbol" is referenced below it may be either a real symbol or a
symbol link.

#### Object References

Separate from but similar to symbol references, the stream contains only
one copy of each object (as determined by `#object_id`) for all objects
except true, false, nil, Fixnums and Symbols (which are stored
separately as described above) a one-indexed 32 bit value will be stored
and reused when the object is encountered again. (The first object has
an index of 1).

"@" represents an object link. Following the type byte is a long giving
the index of the object.

For example, the following stream contains an Array of the same
`"hello"` object twice:


```ruby
"\004\b[\a\"\nhello@\006"
```

#### Instance Variables

"I" indicates that instance variables follow the next object. An object
follows the type byte. Following the object is a length indicating the
number of instance variables for the object. Following the length is a
set of name-value pairs. The names are symbols while the values are
objects. The symbols must be instance variable names (`:@name`).

An Object ("o" type, described below) uses the same format for its
instance variables as described here.

For a String and Regexp (described below) a special instance variable
`:E` is used to indicate the Encoding.

#### Extended

"e" indicates that the next object is extended by a module. An object
follows the type byte. Following the object is a symbol that contains
the name of the module the object is extended by.

#### Array

"\[" represents an Array. Following the type byte is a long indicating
the number of objects in the array. The given number of objects follow
the length.

#### Bignum

"l" represents a Bignum which is composed of three parts:

* sign: A single byte containing "+" for a positive value or "-" for a
  negative value.

* length: A long indicating the number of bytes of Bignum data follows,
  divided by two. Multiply the length by two to determine the number of
  bytes of data that follow.

* data: Bytes of Bignum data representing the number.

The following ruby code will reconstruct the Bignum value from an array
of bytes:


```ruby
result = 0

bytes.each_with_index do |byte, exp|
 result += (byte * 2 ** (exp * 8))
end
```

#### Class and Module

"c" represents a Class object, "m" represents a Module and "M"
represents either a class or module (this is an old-style for
compatibility). No class or module content is included, this type is
only a reference. Following the type byte is a byte sequence which is
used to look up an existing class or module, respectively.

Instance variables are not allowed on a class or module.

If no class or module exists an exception should be raised.

For "c" and "m" types, the loaded object must be a class or module,
respectively.

#### Data

"d" represents a Data object. (Data objects are wrapped pointers from
ruby extensions.) Following the type byte is a symbol indicating the
class for the Data object and an object that contains the state of the
Data object.

To dump a Data object Ruby calls \_dump\_data. To load a Data object
Ruby calls \_load\_data with the state of the object on a newly
allocated instance.

#### Float

"f" represents a Float object. Following the type byte is a byte
sequence containing the float value. The following values are special:

* "inf"\: Positive infinity

* "-inf"\: Negative infinity

* "nan"\: Not a Number

Otherwise the byte sequence contains a C double (loadable by strtod(3)).
Older minor versions of Marshal also stored extra mantissa bits to
ensure portability across platforms but 4.8 does not include these. See
\[ruby-talk:69518\] for some explanation.

#### Hash and Hash with Default Value

"\{" represents a Hash object while "}" represents a Hash with a default
value set (`Hash.new 0`). Following the type byte is a long indicating
the number of key-value pairs in the Hash, the size. Double the given
number of objects follow the size.

For a Hash with a default value, the default value follows all the
pairs.

#### Module and Old Module

#### Object

"o" represents an object that doesn't have any other special form (such
as a user-defined or built-in format). Following the type byte is a
symbol containing the class name of the object. Following the class name
is a long indicating the number of instance variable names and values
for the object. Double the given number of pairs of objects follow the
size.

The keys in the pairs must be symbols containing instance variable
names.

#### Regular Expression

"/" represents a regular expression. Following the type byte is a byte
sequence containing the regular expression source. Following the type
byte is a byte containing the regular expression options
(case-insensitive, etc.) as a signed 8-bit value.

Regular expressions can have an encoding attached through instance
variables (see above). If no encoding is attached escapes for the
following regexp specials not present in ruby 1.8 must be removed: g-m,
o-q, u, y, E, F, H-L, N-V, X, Y.

#### String

'"' represents a String. Following the type byte is a byte sequence
containing the string content. When dumped from ruby 1.9 an encoding
instance variable (`:E` see above) should be included unless the
encoding is binary.

#### Struct

"S" represents a Struct. Following the type byte is a symbol containing
the name of the struct. Following the name is a long indicating the
number of members in the struct. Double the number of objects follow the
member count. Each member is a pair containing the member's symbol and
an object for the value of that member.

If the struct name does not match a Struct subclass in the running ruby
an exception should be raised.

If there is a mismatch between the struct in the currently running ruby
and the member count in the marshaled struct an exception should be
raised.

#### User Class

"C" represents a subclass of a String, Regexp, Array or Hash. Following
the type byte is a symbol containing the name of the subclass. Following
the name is the wrapped object.

#### User Defined

"u" represents an object with a user-defined serialization format using
the `_dump` instance method and `_load` class method. Following the type
byte is a symbol containing the class name. Following the class name is
a byte sequence containing the user-defined representation of the
object.

The class method `_load` is called on the class with a string created
from the byte-sequence.

#### User Marshal

"U" represents an object with a user-defined serialization format using
the `marshal_dump` and `marshal_load` instance methods. Following the
type byte is a symbol containing the class name. Following the class
name is an object containing the data.

Upon loading a new instance must be allocated and `marshal_load` must be
called on the instance with the data.

