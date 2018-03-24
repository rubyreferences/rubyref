# PP

A pretty-printer for Ruby objects.

## What PP Does

Standard output by `#p` returns this: #<PP:0x81fedf0
@genspace=#<Proc:0x81feda0>,
@group\_queue=#<PrettyPrint::GroupQueue:0x81fed3c
@queue=\[\[#<PrettyPrint::Group:0x81fed78 @breakables=\[\], @depth=0,
@break=false>\], \[\]\]>, @buffer=\[\], @newline=\"\\n\",
@group\_stack=\[#<PrettyPrint::Group:0x81fed78 @breakables=\[\],
@depth=0, @break=false>\], @buffer\_width=0, @indent=0, @maxwidth=79,
@output\_width=2,
@output=#<IO:0x8114ee4>></IO:0x8114ee4></Proc:0x81feda0>

Pretty-printed output returns this: #<PP:0x81fedf0 @buffer=\[\],
@buffer\_width=0, @genspace=#<Proc:0x81feda0>, @group\_queue=
#<PrettyPrint::GroupQueue:0x81fed3c @queue=
\[\[#<PrettyPrint::Group:0x81fed78 @break=false, @breakables=\[\],
@depth=0>\], \[\]\]>, @group\_stack= \[#<PrettyPrint::Group:0x81fed78
@break=false, @breakables=\[\], @depth=0>\], @indent=0, @maxwidth=79,
@newline=\"\\n\", @output=#<IO:0x8114ee4>,
@output\_width=2></IO:0x8114ee4></Proc:0x81feda0>

## Usage


```ruby
pp(obj)             #=> obj
pp obj              #=> obj
pp(obj1, obj2, ...) #=> [obj1, obj2, ...]
pp()                #=> nil
```

Output `obj(s)` to `$>` in pretty printed format.

It returns `obj(s)`.

## Output Customization

To define a customized pretty printing function for your classes,
redefine method `#pretty_print(pp)` in the class.

`#pretty_print` takes the `pp` argument, which is an instance of the PP
class. The method uses `#text`, `#breakable`, `#nest`, `#group` and
`#pp` to print the object.

## Pretty-Print JSON

To pretty-print JSON refer to `JSON#pretty_generate`.

## Author

Tanaka Akira [akr@fsij.org](mailto:akr@fsij.org)

[PP Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/pp/rdoc/PP.html)



## PrettyPrint

This class implements a pretty printing algorithm. It finds line breaks
and nice indentations for grouped structure.

By default, the class assumes that primitive elements are strings and
each byte in the strings have single column in width. But it can be used
for other situations by giving suitable arguments for some methods:

* newline object and space generation block for PrettyPrint.new
* optional width argument for `PrettyPrint#text`
* `PrettyPrint#breakable`

There are several candidate uses:

* text formatting using proportional fonts
* multibyte characters which has columns different to number of bytes
* non-string formatting

### Bugs

* Box based formatting?
* Other (better) model/algorithm?

Report any bugs at http://bugs.ruby-lang.org

### References

Christian Lindig, Strictly Pretty, March 2000,
http://www.st.cs.uni-sb.de/~lindig/papers/#pretty

Philip Wadler, A prettier printer, March 1998,
http://homepages.inf.ed.ac.uk/wadler/topics/language-design.html#prettier

### Author

Tanaka Akira [akr@fsij.org](mailto:akr@fsij.org)

[PrettyPrint
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/prettyprint/rdoc/PrettyPrint.html)

