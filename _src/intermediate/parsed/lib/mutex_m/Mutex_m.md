# Mutex_m

# mutex_m.rb

When 'mutex_m' is required, any object that extends or includes Mutex_m will
be treated like a Mutex.

Start by requiring the standard library Mutex_m:

    require "mutex_m.rb"

From here you can extend an object with Mutex instance methods:

    obj = Object.new
    obj.extend Mutex_m

Or mixin Mutex_m into your module to your class inherit Mutex instance methods
--- remember to call super() in your class initialize method.

    class Foo
      include Mutex_m
      def initialize
        # ...
        super()
      end
      # ...
    end
    obj = Foo.new
    # this obj can be handled like Mutex

[Mutex_m Reference](https://ruby-doc.org/stdlib-2.7.0/libdoc/mutex_m/rdoc/Mutex_m.html)
