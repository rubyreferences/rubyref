# Struct

A Struct is a convenient way to bundle a number of attributes together, using
accessor methods, without having to write an explicit class.

The Struct class generates new subclasses that hold a set of members and their
values.  For each member a reader and writer method is created similar to
Module#attr_accessor.

    Customer = Struct.new(:name, :address) do
      def greeting
        "Hello #{name}!"
      end
    end

    dave = Customer.new("Dave", "123 Main")
    dave.name     #=> "Dave"
    dave.greeting #=> "Hello Dave!"

See Struct::new for further examples of creating struct subclasses and
instances.

In the method descriptions that follow, a "member" parameter refers to a
struct member which is either a quoted string (`"name"`) or a Symbol
(`:name`).

[Struct Reference](http://ruby-doc.org/core-2.5.0/Struct.html)