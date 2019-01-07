# GDBM

## Summary

Ruby extension for GNU dbm (gdbm) -- a simple database engine for storing
key-value pairs on disk.

## Description

GNU dbm is a library for simple databases. A database is a file that stores
key-value pairs. Gdbm allows the user to store, retrieve, and delete data by
key. It furthermore allows a non-sorted traversal of all key-value pairs. A
gdbm database thus provides the same functionality as a hash. As with objects
of the Hash class, elements can be accessed with `[]`. Furthermore, GDBM mixes
in the Enumerable module, thus providing convenient methods such as `#find`,
`#collect`, `#map`, etc.

A process is allowed to open several different databases at the same time. A
process can open a database as a "reader" or a "writer". Whereas a reader has
only read-access to the database, a writer has read- and write-access. A
database can be accessed either by any number of readers or by exactly one
writer at the same time.

## Examples

1.  Opening/creating a database, and filling it with some entries:

        require 'gdbm'

        gdbm = GDBM.new("fruitstore.db")
        gdbm["ananas"]    = "3"
        gdbm["banana"]    = "8"
        gdbm["cranberry"] = "4909"
        gdbm.close

2.  Reading out a database:

        require 'gdbm'

        gdbm = GDBM.new("fruitstore.db")
        gdbm.each_pair do |key, value|
          print "#{key}: #{value}\n"
        end
        gdbm.close

    produces

        banana: 8
        ananas: 3
        cranberry: 4909


## Links

*   http://www.gnu.org/software/gdbm/


[GDBM Reference](https://ruby-doc.org/stdlib-2.6/libdoc/gdbm/rdoc/GDBM.html)