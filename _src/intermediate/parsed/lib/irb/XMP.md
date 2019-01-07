# XMP

An example printer for irb.

It's much like the standard library PrettyPrint, that shows the value of each
expression as it runs.

In order to use this library, you must first require it:

    require 'irb/xmp'

Now, you can take advantage of the Object#xmp convenience method.

    xmp <<END
      foo = "bar"
      baz = 42
    END
    #=> foo = "bar"
      #==>"bar"
    #=> baz = 42
      #==>42

You can also create an XMP object, with an optional binding to print
expressions in the given binding:

    ctx = binding
    x = XMP.new ctx
    x.puts
    #=> today = "a good day"
      #==>"a good day"
    ctx.eval 'today # is what?'
    #=> "a good day"

[XMP Reference](https://ruby-doc.org/stdlib-2.6/libdoc/irb/rdoc/XMP.html)
