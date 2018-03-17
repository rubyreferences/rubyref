# String

A `String` object holds and manipulates an arbitrary sequence of bytes,
typically representing characters. String objects may be created using
`String::new` or as literals.

Because of aliasing issues, users of strings should be aware of the methods
that modify the contents of a `String` object.  Typically, methods with names
ending in ``!'' modify their receiver, while those without a ``!'' return a
new `String`.  However, there are exceptions, such as `String#[]=`.
