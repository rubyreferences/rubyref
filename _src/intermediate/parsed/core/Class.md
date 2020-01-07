# Class

Classes in Ruby are first-class objects---each is an instance of class Class.

Typically, you create a new class by using:

    class Name
     # some code describing the class behavior
    end

When a new class is created, an object of type Class is initialized and
assigned to a global constant (Name in this case).

When `Name.new` is called to create a new object, the #new method in Class is
run by default. This can be demonstrated by overriding #new in Class:

    class Class
      alias old_new new
      def new(*args)
        print "Creating a new ", self.name, "\n"
        old_new(*args)
      end
    end

    class Name
    end

    n = Name.new

*produces:*

    Creating a new Name

Classes, modules, and objects are interrelated. In the diagram that follows,
the vertical arrows represent inheritance, and the parentheses metaclasses.
All metaclasses are instances of the class `Class'.
                             +---------+             +-...
                             |         |             |
             BasicObject-----|-->(BasicObject)-------|-...
                 ^           |         ^             |
                 |           |         |             |
              Object---------|----->(Object)---------|-...
                 ^           |         ^             |
                 |           |         |             |
                 +-------+   |         +--------+    |
                 |       |   |         |        |    |
                 |    Module-|---------|--->(Module)-|-...
                 |       ^   |         |        ^    |
                 |       |   |         |        |    |
                 |     Class-|---------|---->(Class)-|-...
                 |       ^   |         |        ^    |
                 |       +---+         |        +----+
                 |                     |
    obj--->OtherClass---------->(OtherClass)-----------...

[Class Reference](https://ruby-doc.org/core-2.7.0/Class.html)
