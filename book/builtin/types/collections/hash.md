# Hash

A Hash is a dictionary-like collection of unique keys and their values.
Also called associative arrays, they are similar to Arrays, but where an
Array uses integers as its index, a Hash allows you to use any object
type.

Hashes enumerate their values in the order that the corresponding keys
were inserted.

A Hash can be easily created by using its implicit form:


```ruby
grades = { "Jane Doe" => 10, "Jim Doe" => 6 }
```

Hashes allow an alternate syntax for keys that are symbols. Instead of


```ruby
options = { :font_size => 10, :font_family => "Arial" }
```

You could write it as:


```ruby
options = { font_size: 10, font_family: "Arial" }
```

Each named key is a symbol you can access in hash:


```ruby
options[:font_size]  # => 10
```

A Hash can also be created through its ::new method:


```ruby
grades = Hash.new
grades["Dorothy Doe"] = 9
```

Hashes have a *default value* that is returned when accessing keys that
do not exist in the hash. If no default is set `nil` is used. You can
set the default value by sending it as an argument to Hash.new:


```ruby
grades = Hash.new(0)
```

Or by using the `#default=` method:


```ruby
grades = {"Timmy Doe" => 8}
grades.default = 0
```

Accessing a value in a Hash requires using its key:


```ruby
puts grades["Jane Doe"] # => 0
```

### Common Uses

Hashes are an easy way to represent data structures, such as


```ruby
books         = {}
books[:matz]  = "The Ruby Programming Language"
books[:black] = "The Well-Grounded Rubyist"
```

Hashes are also commonly used as a way to have named parameters in
functions. Note that no brackets are used below. If a hash is the last
argument on a method call, no braces are needed, thus creating a really
clean interface:


```ruby
Person.create(name: "John Doe", age: 27)

def self.create(params)
  @name = params[:name]
  @age  = params[:age]
end
```

### Hash Keys

Two objects refer to the same hash key when their `hash` value is
identical and the two objects are `eql?` to each other.

A user-defined class may be used as a hash key if the `hash` and `eql?`
methods are overridden to provide meaningful behavior. By default,
separate instances refer to separate hash keys.

A typical implementation of `hash` is based on the object's data while
`eql?` is usually aliased to the overridden `==` method:


```ruby
class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def ==(other)
    self.class === other and
      other.author == @author and
      other.title == @title
  end

  alias eql? ==

  def hash
    @author.hash ^ @title.hash # XOR
  end
end

book1 = Book.new 'matz', 'Ruby in a Nutshell'
book2 = Book.new 'matz', 'Ruby in a Nutshell'

reviews = {}

reviews[book1] = 'Great reference!'
reviews[book2] = 'Nice and compact!'

reviews.length #=> 1
```

See also `Object#hash` and `Object#eql`?

