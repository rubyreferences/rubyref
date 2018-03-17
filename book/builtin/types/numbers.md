# Numeric

Numeric is the class from which all higher-level numeric classes should
inherit.

Numeric allows instantiation of heap-allocated objects. Other core
numeric classes such as Integer are implemented as immediates, which
means that each Integer is a single immutable object which is always
passed by value.


```ruby
a = 1
1.object_id == a.object_id   #=> true
```

There can only ever be one instance of the integer `1`, for example.
Ruby ensures this by preventing instantiation and duplication.


```ruby
Integer.new(1)   #=> NoMethodError: undefined method `new' for Integer:Class
1.dup            #=> TypeError: can't dup Integer
```

For this reason, Numeric should be used when defining other numeric
classes.

Classes which inherit from Numeric must implement `coerce`, which
returns a two-member Array containing an object that has been coerced
into an instance of the new class and `self` (see #coerce).

Inheriting classes should also implement arithmetic operator methods
(`+`, `-`, `*` and `/`) and the `<=>` operator (see Comparable). These
methods may rely on `coerce` to ensure interoperability with instances
of other numeric classes.


```ruby
class Tally < Numeric
  def initialize(string)
    @string = string
  end

  def to_s
    @string
  end

  def to_i
    @string.size
  end

  def coerce(other)
    [self.class.new('|' * other.to_i), self]
  end

  def <=>(other)
    to_i <=> other.to_i
  end

  def +(other)
    self.class.new('|' * (to_i + other.to_i))
  end

  def -(other)
    self.class.new('|' * (to_i - other.to_i))
  end

  def *(other)
    self.class.new('|' * (to_i * other.to_i))
  end

  def /(other)
    self.class.new('|' * (to_i / other.to_i))
  end
end

tally = Tally.new('||')
puts tally * 2            #=> "||||"
puts tally > 1            #=> true
```



## Integer

Holds Integer values. You cannot add a singleton method to an Integer
object, any attempt to do so will raise a TypeError.



## Float

Float objects represent inexact real numbers using the native
architecture's double-precision floating point representation.

Floating point has a different arithmetic and is an inexact number. So
you should know its esoteric system. See following:

* http://docs.sun.com/source/806-3568/ncg\_goldberg.html
* http://wiki.github.com/rdp/ruby\_tutorials\_core/ruby-talk-faq#wiki-floats\_i
  mprecise
* http://en.wikipedia.org/wiki/Floating\_point#Accuracy\_problems



## Rational

A rational number can be represented as a pair of integer numbers: a/b
(b>0), where a is the numerator and b is the denominator. Integer a
equals rational a/1 mathematically.

In Ruby, you can create rational objects with the Kernel#Rational,
to\_r, or rationalize methods or by suffixing `r` to a literal. The
return values will be irreducible fractions.


```ruby
Rational(1)      #=> (1/1)
Rational(2, 3)   #=> (2/3)
Rational(4, -6)  #=> (-2/3)
3.to_r           #=> (3/1)
2/3r             #=> (2/3)
```

You can also create rational objects from floating-point numbers or
strings.


```ruby
Rational(0.3)    #=> (5404319552844595/18014398509481984)
Rational('0.3')  #=> (3/10)
Rational('2/3')  #=> (2/3)

0.3.to_r         #=> (5404319552844595/18014398509481984)
'0.3'.to_r       #=> (3/10)
'2/3'.to_r       #=> (2/3)
0.3.rationalize  #=> (3/10)
```

A rational object is an exact number, which helps you to write programs
without any rounding errors.


```ruby
10.times.inject(0) {|t| t + 0.1 }              #=> 0.9999999999999999
10.times.inject(0) {|t| t + Rational('0.1') }  #=> (1/1)
```

However, when an expression includes an inexact component (numerical
value or operation), it will produce an inexact result.


```ruby
Rational(10) / 3   #=> (10/3)
Rational(10) / 3.0 #=> 3.3333333333333335

Rational(-8) ** Rational(1, 3)
                   #=> (1.0000000000000002+1.7320508075688772i)
```



## Complex

A complex number can be represented as a paired real number with
imaginary unit; a+bi. Where a is real part, b is imaginary part and i is
imaginary unit. Real a equals complex a+0i mathematically.

Complex object can be created as literal, and also by using
Kernel#Complex, Complex::rect, Complex::polar or to\_c method.


```ruby
2+1i                 #=> (2+1i)
Complex(1)           #=> (1+0i)
Complex(2, 3)        #=> (2+3i)
Complex.polar(2, 3)  #=> (-1.9799849932008908+0.2822400161197344i)
3.to_c               #=> (3+0i)
```

You can also create complex object from floating-point numbers or
strings.


```ruby
Complex(0.3)         #=> (0.3+0i)
Complex('0.3-0.5i')  #=> (0.3-0.5i)
Complex('2/3+3/4i')  #=> ((2/3)+(3/4)*i)
Complex('1@2')       #=> (-0.4161468365471424+0.9092974268256817i)

0.3.to_c             #=> (0.3+0i)
'0.3-0.5i'.to_c      #=> (0.3-0.5i)
'2/3+3/4i'.to_c      #=> ((2/3)+(3/4)*i)
'1@2'.to_c           #=> (-0.4161468365471424+0.9092974268256817i)
```

A complex object is either an exact or an inexact number.


```ruby
Complex(1, 1) / 2    #=> ((1/2)+(1/2)*i)
Complex(1, 1) / 2.0  #=> (0.5+0.5i)
```



## Math

The Math module contains module functions for basic trigonometric and
transcendental functions. See class Float for a list of constants that
define Ruby's floating point accuracy.

Domains and codomains are given only for real (not complex) numbers.

