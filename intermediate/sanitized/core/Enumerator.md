# Enumerator

A class which allows both internal and external iteration.

An Enumerator can be created by the following methods.

*   `Kernel#to_enu'm
*   `Kernel#enum_fo'r
*   Enumerator.new


Most methods have two forms: a block form where the contents are evaluated for
each item in the enumeration, and a non-block form which returns a new
Enumerator wrapping the iteration.

    enumerator = %w(one two three).each
    puts enumerator.class # => Enumerator

    enumerator.each_with_object("foo") do |item, obj|
      puts "#{obj}: #{item}"
    end

    # foo: one
    # foo: two
    # foo: three

    enum_with_obj = enumerator.each_with_object("foo")
    puts enum_with_obj.class # => Enumerator

    enum_with_obj.each do |item, obj|
      puts "#{obj}: #{item}"
    end

    # foo: one
    # foo: two
    # foo: three

This allows you to chain Enumerators together.  For example, you can map a
list's elements to strings containing the index and the element as a string
via:

    puts %w[foo bar baz].map.with_index { |w, i| "#{i}:#{w}" }
    # => ["0:foo", "1:bar", "2:baz"]

An Enumerator can also be used as an external iterator. For example,
Enumerator#next returns the next value of the iterator or raises StopIteration
if the Enumerator is at the end.

    e = [1,2,3].each   # returns an enumerator object.
    puts e.next   # => 1
    puts e.next   # => 2
    puts e.next   # => 3
    puts e.next   # raises StopIteration

You can use this to implement an internal iterator as follows:

    def ext_each(e)
      while true
        begin
          vs = e.next_values
        rescue StopIteration
          return $!.result
        end
        y = yield(*vs)
        e.feed y
      end
    end

    o = Object.new

    def o.each
      puts yield
      puts yield(1)
      puts yield(1, 2)
      3
    end

    # use o.each as an internal iterator directly.
    puts o.each {|*x| puts x; [:b, *x] }
    # => [], [:b], [1], [:b, 1], [1, 2], [:b, 1, 2], 3

    # convert o.each to an external iterator for
    # implementing an internal iterator.
    puts ext_each(o.to_enum) {|*x| puts x; [:b, *x] }
    # => [], [:b], [1], [:b, 1], [1, 2], [:b, 1, 2], 3