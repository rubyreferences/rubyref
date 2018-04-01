---
title: dbm, gdbm, sdbm
prev: "/stdlib/misc/drb.html"
next: "/stdlib/misc/timeout.html"
---

# DBM-alike Database Implementations



## DBM

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

[DBM
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/dbm/rdoc/DBM.html)



## GDBM



Ruby extension for GNU dbm (gdbm) -- a simple database engine for
storing key-value pairs on disk.



[GDBM
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/gdbm/rdoc/GDBM.html)



## SDBM

SDBM provides a simple file-based key-value store, which can only store
String keys and values.

Note that Ruby comes with the source code for SDBM, while the DBM and
GDBM standard libraries rely on external libraries and headers.



[SDBM
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/sdbm/rdoc/SDBM.html)

