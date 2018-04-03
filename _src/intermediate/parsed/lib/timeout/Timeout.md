# Timeout

Timeout long-running blocks

## Synopsis

    require 'timeout'
    status = Timeout::timeout(5) {
      # Something that should be interrupted if it takes more than 5 seconds...
    }

## Description

Timeout provides a way to auto-terminate a potentially long-running operation
if it hasn't finished in a fixed amount of time.

Previous versions didn't use a module for namespacing, however #timeout is
provided for backwards compatibility.  You should prefer Timeout.timeout
instead.

## Copyright

Copyright
:   (C) 2000  Network Applied Communication Laboratory, Inc.
Copyright
:   (C) 2000  Information-technology Promotion Agency, Japan


[Timeout Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/timeout/rdoc/Timeout.html)
