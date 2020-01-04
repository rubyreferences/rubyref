---
title: Ruby in Twenty Minutes
prev: intro/irb.html
next: language.html
---

## Ruby in Twenty Minutes[](#ruby-in-twenty-minutes)



### Step 1[](#step-1)



#### Introduction[](#introduction)

This is a small Ruby tutorial that should take no more than 20 minutes
to complete. It makes the assumption that you already have Ruby
installed. (If you do not have Ruby on your computer <a
href='http://ruby-lang.org/en/documentation/installation/'
class='remote' target='_blank'>install</a> it before you get started.)

#### Interactive Ruby[](#interactive-ruby)

Ruby comes with a program that will show the results of any Ruby
statements you feed it. Playing with Ruby code in interactive sessions
like this is a terrific way to learn the language.

Open up IRB (which stands for Interactive Ruby).

* If you’re using **macOS** open up `Terminal` and type `irb`, then hit
  enter.
* If you’re using **Linux**, open up a shell and type `irb` and hit
  enter.
* If you’re using **Windows**, open `Interactive Ruby` from the Ruby
  section of your Start Menu.
^


```irb
irb(main):001:0>
```

Ok, so it’s open. Now what?

Type this: `"Hello World"`


```irb
irb(main):001:0> "Hello World"
=> "Hello World"
```

#### Ruby Obeyed You![](#ruby-obeyed-you)

What just happened? Did we just write the world’s shortest “Hello World”
program? Not exactly. The second line is just IRB’s way of telling us
the result of the last expression it evaluated. If we want to print out
“Hello World” we need a bit more:


```irb
irb(main):002:0> puts "Hello World"
Hello World
=> nil
```

`puts` is the basic command to print something out in Ruby. But then
what’s the `=> nil` bit? That’s the result of the expression. `puts`
always returns nil, which is Ruby’s absolutely-positively-nothing value.

#### Your Free Calculator is Here[](#your-free-calculator-is-here)

Already, we have enough to use IRB as a basic calculator:


```irb
irb(main):003:0> 3+2
=> 5
```

Three plus two. Easy enough. What about three *times* two? You could
type it in, it’s short enough, but you may also be able to go up and
change what you just entered. Try hitting the **up-arrow** on your
keyboard and see if it brings up the line with `3+2` on it. If it does,
you can use the left arrow key to move just after the `+` sign and then
use backspace to change it to a `*` sign.


```irb
irb(main):004:0> 3*2
=> 6
```

Next, let’s try three squared:


```irb
irb(main):005:0> 3**2
=> 9
```

In Ruby `**` is the way you say “to the power of”. But what if you want
to go the other way and find the square root of something?


```irb
irb(main):006:0> Math.sqrt(9)
=> 3.0
```

Ok, wait, what was that last one? If you guessed, “it was figuring out
the square root of nine,” you’re right. But let’s take a closer look at
things. First of all, what’s `Math`?

#### Modules Group Code by Topic[](#modules-group-code-by-topic)

`Math` is a built-in module for mathematics. Modules serve two roles in
Ruby. This shows one role: grouping similar methods together under a
familiar name. `Math` also contains methods like `sin()` and `tan()`.

Next is a dot. What does the dot do? The dot is how you identify the
receiver of a message. What’s the message? In this case it’s `sqrt(9)`,
which means call the method `sqrt`, shorthand for “square root” with the
parameter of `9`.

The result of this method call is the value `3.0`. You might notice it’s
not just `3`. That’s because most of the time the square root of a
number won’t be an integer, so the method always returns a
floating-point number.

What if we want to remember the result of some of this math? Assign the
result to a variable.


```irb
irb(main):007:0> a = 3 ** 2
=> 9
irb(main):008:0> b = 4 ** 2
=> 16
irb(main):009:0> Math.sqrt(a+b)
=> 5.0
```

As great as this is for a calculator, we’re getting away from the
traditional `Hello World` message that beginning tutorials are supposed
to focus on… so let’s go back to that.



### Step 2[](#step-2)



What if we want to say “Hello” a lot without getting our fingers all
tired? We need to define a method!


```irb
irb(main):010:0> def hi
irb(main):011:1> puts "Hello World!"
irb(main):012:1> end
=> :hi
```

The code `def hi` starts the definition of the method. It tells Ruby
that we’re defining a method, that its name is `hi`. The next line is
the body of the method, the same line we saw earlier: `puts "Hello
World"`. Finally, the last line `end` tells Ruby we’re done defining the
method. Ruby’s response `=> :hi` tells us that it knows we’re done
defining the method. This response could be `=> nil` for Ruby 2.0 and
earlier versions. But, it's not important here, so let's go on.

#### The Brief, Repetitive Lives of a Method[](#the-brief-repetitive-lives-of-a-method)

Now let’s try running that method a few times:


```irb
irb(main):013:0> hi
Hello World!
=> nil
irb(main):014:0> hi()
Hello World!
=> nil
```

Well, that was easy. Calling a method in Ruby is as easy as just
mentioning its name to Ruby. If the method doesn’t take parameters
that’s all you need. You can add empty parentheses if you’d like, but
they’re not needed.

What if we want to say hello to one person, and not the whole world?
Just redefine `hi` to take a name as a parameter.


```irb
irb(main):015:0> def hi(name)
irb(main):016:1> puts "Hello #{name}!"
irb(main):017:1> end
=> :hi
irb(main):018:0> hi("Matz")
Hello Matz!
=> nil
```

So it works… but let’s take a second to see what’s going on here.

#### Holding Spots in a String[](#holding-spots-in-a-string)

What’s the `#{name}` bit? That’s Ruby’s way of inserting something into
a string. The bit between the braces is turned into a string (if it
isn’t one already) and then substituted into the outer string at that
point. You can also use this to make sure that someone’s name is
properly capitalized:


```irb
irb(main):019:0> def hi(name = "World")
irb(main):020:1> puts "Hello #{name.capitalize}!"
irb(main):021:1> end
=> :hi
irb(main):022:0> hi "chris"
Hello Chris!
=> nil
irb(main):023:0> hi
Hello World!
=> nil
```

A couple of other tricks to spot here. One is that we’re calling the
method without parentheses again. If it’s obvious what you’re doing, the
parentheses are optional. The other trick is the default parameter
`World`. What this is saying is “If the name isn’t supplied, use the
default name of `"World"`”.

#### Evolving Into a Greeter[](#evolving-into-a-greeter)

What if we want a real greeter around, one that remembers your name and
welcomes you and treats you always with respect. You might want to use
an object for that. Let’s create a “Greeter” class.


```irb
irb(main):024:0> class Greeter
irb(main):025:1>   def initialize(name = "World")
irb(main):026:2>     @name = name
irb(main):027:2>   end
irb(main):028:1>   def say_hi
irb(main):029:2>     puts "Hi #{@name}!"
irb(main):030:2>   end
irb(main):031:1>   def say_bye
irb(main):032:2>     puts "Bye #{@name}, come back soon."
irb(main):033:2>   end
irb(main):034:1> end
=> :say_bye
```

The new keyword here is `class`. This defines a new class called Greeter
and a bunch of methods for that class. Also notice `@name`. This is an
instance variable, and is available to all the methods of the class. As
you can see it’s used by `say_hi` and `say_bye`.

So how do we get this Greeter class set in motion? Create an object.



### Step 3[](#step-3)



Now let’s create a greeter object and use it:


```irb
irb(main):035:0> greeter = Greeter.new("Pat")
=> #<Greeter:0x16cac @name="Pat">
irb(main):036:0> greeter.say_hi
Hi Pat!
=> nil
irb(main):037:0> greeter.say_bye
Bye Pat, come back soon.
=> nil
```

Once the `greeter` object is created, it remembers that the name is Pat.
Hmm, what if we want to get at the name directly?


```irb
irb(main):038:0> greeter.@name
SyntaxError: (irb):38: syntax error, unexpected tIVAR, expecting '('
```

Nope, can’t do it.

#### Under the Object’s Skin[](#under-the-objects-skin)

Instance variables are hidden away inside the object. They’re not
terribly hidden, you see them whenever you inspect the object, and there
are other ways of accessing them, but Ruby uses the good object-oriented
approach of keeping data sort-of hidden away.

So what methods do exist for Greeter objects?


```irb
irb(main):039:0> Greeter.instance_methods
=> [:say_hi, :say_bye, :instance_of?, :public_send,
    :instance_variable_get, :instance_variable_set,
    :instance_variable_defined?, :remove_instance_variable,
    :private_methods, :kind_of?, :instance_variables, :tap,
    :is_a?, :extend, :define_singleton_method, :to_enum,
    :enum_for, :<=>, :===, :=~, :!~, :eql?, :respond_to?,
    :freeze, :inspect, :display, :send, :object_id, :to_s,
    :method, :public_method, :singleton_method, :nil?, :hash,
    :class, :singleton_class, :clone, :dup, :itself, :taint,
    :tainted?, :untaint, :untrust, :trust, :untrusted?, :methods,
    :protected_methods, :frozen?, :public_methods, :singleton_methods,
    :!, :==, :!=, :__send__, :equal?, :instance_eval, :instance_exec, :__id__]
```

Whoa. That’s a lot of methods. We only defined two methods. What’s going
on here? Well this is **all** of the methods for Greeter objects, a
complete list, including ones defined by ancestor classes. If we want to
just list methods defined for Greeter we can tell it to not include
ancestors by passing it the parameter `false`, meaning we don’t want
methods defined by ancestors.


```irb
irb(main):040:0> Greeter.instance_methods(false)
=> [:say_hi, :say_bye]
```

Ah, that’s more like it. So let’s see which methods our greeter object
responds to:


```irb
irb(main):041:0> greeter.respond_to?("name")
=> false
irb(main):042:0> greeter.respond_to?("say_hi")
=> true
irb(main):043:0> greeter.respond_to?("to_s")
=> true
```

So, it knows `say_hi`, and `to_s` (meaning convert something to a
string, a method that’s defined by default for every object), but it
doesn’t know `name`.

#### Altering Classes—It’s Never Too Late[](#altering-classesits-never-too-late)

But what if you want to be able to view or change the name? Ruby
provides an easy way of providing access to an object’s variables.


```irb
irb(main):044:0> class Greeter
irb(main):045:1>   attr_accessor :name
irb(main):046:1> end
=> nil
```

In Ruby, you can open a class up again and modify it. The changes will
be present in any new objects you create and even available in existing
objects of that class. So, let’s create a new object and play with its
`@name` property.


```irb
irb(main):047:0> greeter = Greeter.new("Andy")
=> #<Greeter:0x3c9b0 @name="Andy">
irb(main):048:0> greeter.respond_to?("name")
=> true
irb(main):049:0> greeter.respond_to?("name=")
=> true
irb(main):050:0> greeter.say_hi
Hi Andy!
=> nil
irb(main):051:0> greeter.name="Betty"
=> "Betty"
irb(main):052:0> greeter
=> #<Greeter:0x3c9b0 @name="Betty">
irb(main):053:0> greeter.name
=> "Betty"
irb(main):054:0> greeter.say_hi
Hi Betty!
=> nil
```

Using `attr_accessor` defined two new methods for us, `name` to get the
value, and `name=` to set it.

#### Greeting Anything and Everything, MegaGreeter Neglects None![](#greeting-anything-and-everything-megagreeter-neglects-none)

This greeter isn’t all that interesting though, it can only deal with
one person at a time. What if we had some kind of MegaGreeter that could
either greet the world, one person, or a whole list of people?

Let’s write this one in a file instead of directly in the interactive
Ruby interpreter IRB.

To quit IRB, type “quit”, “exit” or just hit Control-D.


```ruby
#!/usr/bin/env ruby

class MegaGreeter
  attr_accessor :names

  # Create the object
  def initialize(names = "World")
    @names = names
  end

  # Say hi to everybody
  def say_hi
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("each")
      # @names is a list of some kind, iterate!
      @names.each do |name|
        puts "Hello #{name}!"
      end
    else
      puts "Hello #{@names}!"
    end
  end

  # Say bye to everybody
  def say_bye
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("join")
      # Join the list elements with commas
      puts "Goodbye #{@names.join(", ")}.  Come back soon!"
    else
      puts "Goodbye #{@names}.  Come back soon!"
    end
  end
end


if __FILE__ == $0
  mg = MegaGreeter.new
  mg.say_hi
  mg.say_bye

  # Change name to be "Zeke"
  mg.names = "Zeke"
  mg.say_hi
  mg.say_bye

  # Change the name to an array of names
  mg.names = ["Albert", "Brenda", "Charles",
              "Dave", "Engelbert"]
  mg.say_hi
  mg.say_bye

  # Change to nil
  mg.names = nil
  mg.say_hi
  mg.say_bye
end
```

Save this file as “ri20min.rb”, and run it as “ruby ri20min.rb”. The
output should be:


```
Hello World!
Goodbye World.  Come back soon!
Hello Zeke!
Goodbye Zeke.  Come back soon!
Hello Albert!
Hello Brenda!
Hello Charles!
Hello Dave!
Hello Engelbert!
Goodbye Albert, Brenda, Charles, Dave, Engelbert.  Come
back soon!
...
...
```

There are a lot of new things thrown into this final example that we can
take a deeper look at.



So, looking deeper at our new program, notice the initial lines, which
begin with a hash mark (#). In Ruby, anything on a line after a hash
mark is a comment and is ignored by the interpreter. The first line of
the file is a special case, and under a Unix-like operating system tells
the shell how to run the file. The rest of the comments are there just
for clarity.

Our `say_hi` method has become a bit trickier:


```ruby
# Say hi to everybody
def say_hi
  if @names.nil?
    puts "..."
  elsif @names.respond_to?("each")
    # @names is a list of some kind, iterate!
    @names.each do |name|
      puts "Hello #{name}!"
    end
  else
    puts "Hello #{@names}!"
  end
end
```

It now looks at the `@names` instance variable to make decisions. If
it’s nil, it just prints out three dots. No point greeting nobody,
right?

#### Cycling and Looping—a.k.a. Iteration[](#cycling-and-loopingaka-iteration)

If the `@names` object responds to `each`, it is something that you can
iterate over, so iterate over it and greet each person in turn. Finally,
if `@names` is anything else, just let it get turned into a string
automatically and do the default greeting.

Let’s look at that iterator in more depth:


```ruby
@names.each do |name|
  puts "Hello #{name}!"
end
```

`each` is a method that accepts a block of code then runs that block of
code for every element in a list, and the bit between `do` and `end` is
just such a block. A block is like an anonymous function or `lambda`.
The variable between pipe characters is the parameter for this block.

What happens here is that for every entry in a list, `name` is bound to
that list element, and then the expression `puts "Hello #{name}!"` is
run with that name.

Most other programming languages handle going over a list using the
`for` loop, which in C looks something like:


```
for (i=0; i<number_of_elements; i++)
{
  do_something_with(element[i]);
}
```

This works, but isn’t very elegant. You need a throw-away variable like
`i`, have to figure out how long the list is, and have to explain how to
walk over the list. The Ruby way is much more elegant, all the
housekeeping details are hidden within the `each` method, all you need
to do is to tell it what to do with each element. Internally, the `each`
method will essentially call `yield "Albert"`, then `yield "Brenda"` and
then `yield "Charles"`, and so on.

#### Blocks, the Highly Sparkling Glint on the Edge of Ruby[](#blocks-the-highly-sparkling-glint-on-the-edge-of-ruby)

The real power of blocks is when dealing with things that are more
complicated than lists. Beyond handling simple housekeeping details
within the method, you can also handle setup, teardown, and errors—all
hidden away from the cares of the user.


```ruby
# Say bye to everybody
def say_bye
  if @names.nil?
    puts "..."
  elsif @names.respond_to?("join")
    # Join the list elements with commas
    puts "Goodbye #{@names.join(", ")}.  Come back soon!"
  else
    puts "Goodbye #{@names}.  Come back soon!"
  end
end
```

The `say_bye` method doesn’t use `each`, instead it checks to see if
`@names` responds to the `join` method, and if so, uses it. Otherwise,
it just prints out the variable as a string. This method of not caring
about the actual *type* of a variable, just relying on what methods it
supports is known as “Duck Typing”, as in “if it walks like a duck and
quacks like a duck…”. The benefit of this is that it doesn’t
unnecessarily restrict the types of variables that are supported. If
someone comes up with a new kind of list class, as long as it implements
the `join` method with the same semantics as other lists, everything
will work as planned.

#### Kicking Off the Script[](#kicking-off-the-script)

So, that’s the MegaGreeter class, the rest of the file just calls
methods on that class. There’s one final trick to notice, and that’s the
line:


```
if __FILE__ == $0
```

`__FILE__` is the magic variable that contains the name of the current
file. `$0` is the name of the file used to start the program. This check
says “If this is the main file being used…” This allows a file to be
used as a library, and not to execute code in that context, but if the
file is being used as an executable, then execute that code.

#### Consider Yourself Introduced[](#consider-yourself-introduced)

So that’s it for the quick tour of Ruby. There’s a lot more to explore,
the different control structures that Ruby offers; the use of blocks and
`yield`; modules as mixins; and more. I hope this taste of Ruby has left
you wanting to learn more.

