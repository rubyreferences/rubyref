# Encoding

An Encoding instance represents a character encoding usable in Ruby. It is
defined as a constant under the Encoding namespace. It has a name and
optionally, aliases:

    Encoding::ISO_8859_1.name
    #=> "ISO-8859-1"

    Encoding::ISO_8859_1.names
    #=> ["ISO-8859-1", "ISO8859-1"]

Ruby methods dealing with encodings return or accept Encoding instances as
arguments (when a method accepts an Encoding instance as an argument, it can
be passed an Encoding name or alias instead).

    "some string".encoding
    #=> #<Encoding:UTF-8>

    string = "some string".encode(Encoding::ISO_8859_1)
    #=> "some string"
    string.encoding
    #=> #<Encoding:ISO-8859-1>

    "some string".encode "ISO-8859-1"
    #=> "some string"

`Encoding::ASCII_8BIT` is a special encoding that is usually used for a byte
string, not a character string. But as the name insists, its characters in the
range of ASCII are considered as ASCII characters. This is useful when you use
ASCII-8BIT characters with other ASCII compatible characters.

## Changing an encoding

The associated Encoding of a String can be changed in two different ways.

First, it is possible to set the Encoding of a string to a new Encoding
without changing the internal byte representation of the string, with
String#force_encoding. This is how you can tell Ruby the correct encoding of a
string.

    string
    #=> "R\xC3\xA9sum\xC3\xA9"
    string.encoding
    #=> #<Encoding:ISO-8859-1>
    string.force_encoding(Encoding::UTF_8)
    #=> "R\u00E9sum\u00E9"

Second, it is possible to transcode a string, i.e. translate its internal byte
representation to another encoding. Its associated encoding is also set to the
other encoding. See `String#encode` for the various forms of transcoding, and
the Encoding::Converter class for additional control over the transcoding
process.

    string
    #=> "R\u00E9sum\u00E9"
    string.encoding
    #=> #<Encoding:UTF-8>
    string = string.encode!(Encoding::ISO_8859_1)
    #=> "R\xE9sum\xE9"
    string.encoding
    #=> #<Encoding::ISO-8859-1>

## Script encoding

All Ruby script code has an associated Encoding which any String literal
created in the source code will be associated to.

The default script encoding is `Encoding::UTF-8` after v2.0, but it can be
changed by a magic comment on the first line of the source code file (or
second line, if there is a shebang line on the first). The comment must
contain the word `coding` or `encoding`, followed by a colon, space and the
Encoding name or alias:

    # encoding: UTF-8

    "some string".encoding
    #=> #<Encoding:UTF-8>

The `__ENCODING__` keyword returns the script encoding of the file which the
keyword is written:

    # encoding: ISO-8859-1

    __ENCODING__
    #=> #<Encoding:ISO-8859-1>

`ruby -K` will change the default locale encoding, but this is not
recommended. Ruby source files should declare its script encoding by a magic
comment even when they only depend on US-ASCII strings or regular expressions.

## Locale encoding

The default encoding of the environment. Usually derived from locale.

see Encoding.locale_charmap, Encoding.find('locale')

## Filesystem encoding

The default encoding of strings from the filesystem of the environment. This
is used for strings of file names or paths.

see Encoding.find('filesystem')

## External encoding

Each IO object has an external encoding which indicates the encoding that Ruby
will use to read its data. By default Ruby sets the external encoding of an IO
object to the default external encoding. The default external encoding is set
by locale encoding or the interpreter `-E` option. Encoding.default_external
returns the current value of the external encoding.

    ENV["LANG"]
    #=> "UTF-8"
    Encoding.default_external
    #=> #<Encoding:UTF-8>

    $ ruby -E ISO-8859-1 -e "p Encoding.default_external"
    #<Encoding:ISO-8859-1>

    $ LANG=C ruby -e 'p Encoding.default_external'
    #<Encoding:US-ASCII>

The default external encoding may also be set through
Encoding.default_external=, but you should not do this as strings created
before and after the change will have inconsistent encodings.  Instead use
`ruby -E` to invoke ruby with the correct external encoding.

When you know that the actual encoding of the data of an IO object is not the
default external encoding, you can reset its external encoding with
IO#set_encoding or set it at IO object creation (see IO.new options).

## Internal encoding

To process the data of an IO object which has an encoding different from its
external encoding, you can set its internal encoding. Ruby will use this
internal encoding to transcode the data when it is read from the IO object.

Conversely, when data is written to the IO object it is transcoded from the
internal encoding to the external encoding of the IO object.

The internal encoding of an IO object can be set with `IO#set_encoding` or at IO
object creation (see IO.new options).

The internal encoding is optional and when not set, the Ruby default internal
encoding is used. If not explicitly set this default internal encoding is
`nil` meaning that by default, no transcoding occurs.

The default internal encoding can be set with the interpreter option `-E`.
Encoding.default_internal returns the current internal encoding.

    $ ruby -e 'p Encoding.default_internal'
    nil

    $ ruby -E ISO-8859-1:UTF-8 -e "p [Encoding.default_external, \
      Encoding.default_internal]"
    [#<Encoding:ISO-8859-1>, #<Encoding:UTF-8>]

The default internal encoding may also be set through
Encoding.default_internal=, but you should not do this as strings created
before and after the change will have inconsistent encodings.  Instead use
`ruby -E` to invoke ruby with the correct internal encoding.

## IO encoding example

In the following example a UTF-8 encoded string "Ru00E9sumu00E9" is transcoded
for output to ISO-8859-1 encoding, then read back in and transcoded to UTF-8:

    string = "R\u00E9sum\u00E9"

    open("transcoded.txt", "w:ISO-8859-1") do |io|
      io.write(string)
    end

    puts "raw text:"
    p File.binread("transcoded.txt")
    puts

    open("transcoded.txt", "r:ISO-8859-1:UTF-8") do |io|
      puts "transcoded text:"
      p io.read
    end

While writing the file, the internal encoding is not specified as it is only
necessary for reading.  While reading the file both the internal and external
encoding must be specified to obtain the correct result.

    $ ruby t.rb
    raw text:
    "R\xE9sum\xE9"

    transcoded text:
    "R\u00E9sum\u00E9"

[Encoding Reference](http://ruby-doc.org/core-2.5.0/Encoding.html)