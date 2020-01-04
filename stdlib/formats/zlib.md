---
title: zlib
prev: "/stdlib/formats/rss.html"
next: "/stdlib/development.html"
---


```ruby
require 'zlib'
```

## Zlib[](#zlib)

This module provides access to the <a href='http://zlib.net'
class='remote' target='_blank'>zlib library</a>. Zlib is designed to be
a portable, free, general-purpose, legally unencumbered -- that is, not
covered by any patents -- lossless data-compression library for use on
virtually any computer hardware and operating system.

The zlib compression library provides in-memory compression and
decompression functions, including integrity checks of the uncompressed
data.

The zlib compressed data format is described in RFC 1950, which is a
wrapper around a deflate stream which is described in RFC 1951.

The library also supports reading and writing files in gzip (.gz) format
with an interface similar to that of IO. The gzip format is described in
RFC 1952 which is also a wrapper around a deflate stream.

The zlib format was designed to be compact and fast for use in memory
and on communications channels. The gzip format was designed for
single-file compression on file systems, has a larger header than zlib
to maintain directory information, and uses a different, slower check
method than zlib.

See your system's zlib.h for further information about zlib

### Sample usage[](#sample-usage)

Using the wrapper to compress strings with default parameters is quite
simple:


```ruby
require "zlib"

data_to_compress = File.read("don_quixote.txt")

puts "Input size: #{data_to_compress.size}"
#=> Input size: 2347740

data_compressed = Zlib::Deflate.deflate(data_to_compress)

puts "Compressed size: #{data_compressed.size}"
#=> Compressed size: 887238

uncompressed_data = Zlib::Inflate.inflate(data_compressed)

puts "Uncompressed data is: #{uncompressed_data}"
#=> Uncompressed data is: The Project Gutenberg EBook of Don Quixote...
```

<a href='https://ruby-doc.org/stdlib-2.7.0/libdoc/zlib/rdoc/Zlib.html'
class='ruby-doc remote' target='_blank'>Zlib Reference</a>

