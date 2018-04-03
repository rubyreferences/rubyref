# DBM

## Introduction

The DBM class provides a wrapper to a Unix-style
[dbm](http://en.wikipedia.org/wiki/Dbm) or Database Manager library.

Dbm databases do not have tables or columns; they are simple key-value data
stores, like a Ruby Hash except not resident in RAM. Keys and values must be
strings.

The exact library used depends on how Ruby was compiled. It could be any of
the following:

*   The original ndbm library is released in 4.3BSD. It is based on dbm
    library in Unix Version 7 but has different API to support multiple
    databases in a process.

*   [Berkeley DB](http://en.wikipedia.org/wiki/Berkeley_DB) versions 1 thru 5,
    also known as BDB and Sleepycat DB, now owned by Oracle Corporation.

*   Berkeley DB 1.x, still found in 4.4BSD derivatives (FreeBSD, OpenBSD,
    etc).

*   [gdbm](http://www.gnu.org/software/gdbm/), the GNU implementation of dbm.
*   [qdbm](http://fallabs.com/qdbm/index.html), another open source
    reimplementation of dbm.


All of these dbm implementations have their own Ruby interfaces available,
which provide richer (but varying) APIs.

## Cautions

Before you decide to use DBM, there are some issues you should consider:

*   Each implementation of dbm has its own file format. Generally, dbm
    libraries will not read each other's files. This makes dbm files a bad
    choice for data exchange.

*   Even running the same OS and the same dbm implementation, the database
    file format may depend on the CPU architecture. For example, files may not
    be portable between PowerPC and 386, or between 32 and 64 bit Linux.

*   Different versions of Berkeley DB use different file formats. A change to
    the OS may therefore break DBM access to existing files.

*   Data size limits vary between implementations. Original Berkeley DB was
    limited to 2GB of data. Dbm libraries also sometimes limit the total size
    of a key/value pair, and the total size of all the keys that hash to the
    same value. These limits can be as little as 512 bytes. That said, gdbm
    and recent versions of Berkeley DB do away with these limits.


Given the above cautions, DBM is not a good choice for long term storage of
important data. It is probably best used as a fast and easy alternative to a
Hash for processing large amounts of data.

## Example

    require 'dbm'
    db = DBM.open('rfcs', 0666, DBM::WRCREAT)
    db['822'] = 'Standard for the Format of ARPA Internet Text Messages'
    db['1123'] = 'Requirements for Internet Hosts - Application and Support'
    db['3068'] = 'An Anycast Prefix for 6to4 Relay Routers'
    puts db['822']

[DBM Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/dbm/rdoc/DBM.html)