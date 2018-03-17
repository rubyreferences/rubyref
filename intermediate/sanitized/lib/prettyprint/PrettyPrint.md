# PrettyPrint

This class implements a pretty printing algorithm. It finds line breaks and
nice indentations for grouped structure.

By default, the class assumes that primitive elements are strings and each
byte in the strings have single column in width. But it can be used for other
situations by giving suitable arguments for some methods:

*   newline object and space generation block for PrettyPrint.new
*   optional width argument for `PrettyPrint#tex't
*   `PrettyPrint#breakabl'e


There are several candidate uses:

*   text formatting using proportional fonts
*   multibyte characters which has columns different to number of bytes
*   non-string formatting


## Bugs

*   Box based formatting?
*   Other (better) model/algorithm?


Report any bugs at http://bugs.ruby-lang.org

## References
Christian Lindig, Strictly Pretty, March 2000,
http://www.st.cs.uni-sb.de/~lindig/papers/#pretty

Philip Wadler, A prettier printer, March 1998,
http://homepages.inf.ed.ac.uk/wadler/topics/language-design.html#prettier

## Author
Tanaka Akira <akr@fsij.org>