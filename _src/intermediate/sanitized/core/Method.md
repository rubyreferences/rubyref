# Method

Method objects are created by `Object#method`, and are associated with a
particular object (not just with a class). They may be used to invoke the
method within the object, and as a block associated with an iterator. They may
also be unbound from one object (creating an `UnboundMethod`) and bound to
another.

    class Thing
      def square(n)
        n*n
      end
    end
    thing = Thing.new
    meth  = thing.method(:square)

    meth.call(9)                 #=> 81
    [ 1, 2, 3 ].collect(&meth)   #=> [1, 4, 9]

    [ 1, 2, 3 ].each(&method(:puts)) #=> prints 1, 2, 3

    require 'date'
    %w[2017-03-01 2017-03-02].collect(&Date.method(:parse))
    #=> [#<Date: 2017-03-01 ((2457814j,0s,0n),+0s,2299161j)>, #<Date: 2017-03-02 ((2457815j,0s,0n),+0s,2299161j)>]

[Method Reference](https://ruby-doc.org/core-2.6/Method.html)