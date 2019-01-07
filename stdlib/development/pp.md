---
title: 'pp: Debug Print'
prev: "/stdlib/development/logger.html"
next: "/stdlib/development/profiler.html"
---

## PP[](#pp)

> Since Ruby 2.5, this library is required by default

A pretty-printer for Ruby objects.

### What PP Does[](#what-pp-does)

Standard output by `#p` returns this:


```ruby
#<PP:0x81fedf0 @genspace=#<Proc:0x81feda0>, @group_queue=#<PrettyPrint::GroupQueue:0x81fed3c @queue=[[#<PrettyPrint::Group:0x81fed78 @breakables=[], @depth=0, @break=false>], []]>, @buffer=[], @newline="\n", @group_stack=[#<PrettyPrint::Group:0x81fed78 @breakables=[], @depth=0, @break=false>], @buffer_width=0, @indent=0, @maxwidth=79, @output_width=2, @output=#<IO:0x8114ee4>>
```

Pretty-printed output returns this:


```
#<PP:0x81fedf0
 @buffer=[],
 @buffer_width=0,
 @genspace=#<Proc:0x81feda0>,
 @group_queue=
  #<PrettyPrint::GroupQueue:0x81fed3c
   @queue=
    [[#<PrettyPrint::Group:0x81fed78 @break=false, @breakables=[], @depth=0>],
     []]>,
 @group_stack=
  [#<PrettyPrint::Group:0x81fed78 @break=false, @breakables=[], @depth=0>],
 @indent=0,
 @maxwidth=79,
 @newline="\n",
 @output=#<IO:0x8114ee4>,
 @output_width=2>
```

### Usage[](#usage)


```
pp(obj)             #=> obj
pp obj              #=> obj
pp(obj1, obj2, ...) #=> [obj1, obj2, ...]
pp()                #=> nil
```

Output `obj(s)` to `$>` in pretty printed format.

It returns `obj(s)`.

### Output Customization[](#output-customization)

To define a customized pretty printing function for your classes,
redefine method `#pretty_print(pp)` in the class.

`#pretty_print` takes the `pp` argument, which is an instance of the PP
class. The method uses `#text`, `#breakable`, `#nest`, `#group` and
`#pp` to print the object.



<a
href='https://ruby-doc.org/stdlib-2.6/libdoc/prettyprint/rdoc/PrettyPrint.html'
class='ruby-doc remote' target='_blank'>PrettyPrint Reference</a>

