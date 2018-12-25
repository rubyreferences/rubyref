---
title: dbm, gdbm, sdbm
prev: "/stdlib/misc/drb.html"
next: "/stdlib/misc/timeout.html"
---

## DBM-alike Database Implementations[](#dbm-alike-database-implementations)



### DBM[](#dbm)

The DBM class provides a wrapper to a Unix-style <a
href='http://en.wikipedia.org/wiki/Dbm' class='remote'
target='_blank'>dbm</a> or Database Manager library.

Dbm databases do not have tables or columns; they are simple key-value
data stores, like a Ruby Hash except not resident in RAM. Keys and
values must be strings.

The exact library used depends on how Ruby was compiled. It could be any
of the following:

* The original ndbm library is released in 4.3BSD. It is based on dbm
  library in Unix Version 7 but has different API to support multiple
  databases in a process.

* <a href='http://en.wikipedia.org/wiki/Berkeley_DB' class='remote'
  target='_blank'>Berkeley DB</a> versions 1 thru 5, also known as BDB
  and Sleepycat DB, now owned by Oracle Corporation.

* Berkeley DB 1.x, still found in 4.4BSD derivatives (FreeBSD, OpenBSD,
  etc).

* <a href='http://www.gnu.org/software/gdbm/' class='remote'
  target='_blank'>gdbm</a>, the GNU implementation of dbm.
* <a href='http://fallabs.com/qdbm/index.html' class='remote'
  target='_blank'>qdbm</a>, another open source reimplementation of dbm.

All of these dbm implementations have their own Ruby interfaces
available, which provide richer (but varying) APIs.

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/dbm/rdoc/DBM.html'
class='ruby-doc remote' target='_blank'>DBM Reference</a>



### GDBM[](#gdbm)



Ruby extension for GNU dbm (gdbm) -- a simple database engine for
storing key-value pairs on disk.

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/gdbm/rdoc/GDBM.html'
class='ruby-doc remote' target='_blank'>GDBM Reference</a>



### SDBM[](#sdbm)

SDBM provides a simple file-based key-value store, which can only store
String keys and values.

Note that Ruby comes with the source code for SDBM, while the DBM and
GDBM standard libraries rely on external libraries and headers.

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/sdbm/rdoc/SDBM.html'
class='ruby-doc remote' target='_blank'>SDBM Reference</a>

