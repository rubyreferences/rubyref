# OpenStruct

An OpenStruct is a data structure, similar to a Hash, that allows the
definition of arbitrary attributes with their accompanying values. This
is accomplished by using Ruby's metaprogramming to define methods on the
class itself.

## Examples


```ruby
require "ostruct"

person = OpenStruct.new
person.name = "John Smith"
person.age  = 70

person.name      # => "John Smith"
person.age       # => 70
person.address   # => nil
```

An OpenStruct employs a Hash internally to store the attributes and
values and can even be initialized with one:


```ruby
australia = OpenStruct.new(:country => "Australia", :capital => "Canberra")
  # => #<OpenStruct country="Australia", capital="Canberra">
```

Hash keys with spaces or characters that could normally not be used for
method calls (e.g. `()[]*`) will not be immediately available on the
OpenStruct object as a method for retrieval or assignment, but can still
be reached through the Object#send method.


```ruby
measurements = OpenStruct.new("length (in inches)" => 24)
measurements.send("length (in inches)")   # => 24

message = OpenStruct.new(:queued? => true)
message.queued?                           # => true
message.send("queued?=", false)
message.queued?                           # => false
```

Removing the presence of an attribute requires the execution of the
delete\_field method as setting the property value to `nil` will not
remove the attribute.


```ruby
first_pet  = OpenStruct.new(:name => "Rowdy", :owner => "John Smith")
second_pet = OpenStruct.new(:name => "Rowdy")

first_pet.owner = nil
first_pet                 # => #<OpenStruct name="Rowdy", owner=nil>
first_pet == second_pet   # => false

first_pet.delete_field(:owner)
first_pet                 # => #<OpenStruct name="Rowdy">
first_pet == second_pet   # => true
```

## Implementation

An OpenStruct utilizes Ruby's method lookup structure to find and define
the necessary methods for properties. This is accomplished through the
methods method\_missing and define\_singleton\_method.

This should be a consideration if there is a concern about the
performance of the objects that are created, as there is much more
overhead in the setting of these properties compared to using a Hash or
a Struct.

