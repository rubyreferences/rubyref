---
title: Numbers
prev: "/builtin/types/comparable.html"
next: "/builtin/types/symbol-string.html"
---

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
Integer.new(1)   #=> NoMethodError: undefined method `new` for Integer:Class
1.dup            #=> TypeError: can't dup Integer
```

For this reason, Numeric should be used when defining other numeric
classes.

Classes which inherit from Numeric must implement `coerce`, which
returns a two-member Array containing an object that has been coerced
into an instance of the new class and `self` (see `#coerce`).

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

<a href='https://ruby-doc.org/core-2.5.0/Numeric.html' class='ruby-doc
remote' target='_blank'>Numeric Reference</a>



## Integer

Holds Integer values. You cannot add a singleton method to an Integer
object, any attempt to do so will raise a TypeError.

<a href='https://ruby-doc.org/core-2.5.0/Integer.html' class='ruby-doc
remote' target='_blank'>Integer Reference</a>



## Float

Float objects represent inexact real numbers using the native
architecture's double-precision floating point representation.

Floating point has a different arithmetic and is an inexact number. So
you should know its esoteric system. See following:

* http://docs.sun.com/source/806-3568/ncg_goldberg.html
* http://wiki.github.com/rdp/ruby_tutorials_core/ruby-talk-faq#wiki-floats_imprecise
* http://en.wikipedia.org/wiki/Floating_point#Accuracy_problems

<a href='https://ruby-doc.org/core-2.5.0/Float.html' class='ruby-doc
remote' target='_blank'>Float Reference</a>



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

<a href='https://ruby-doc.org/core-2.5.0/Rational.html' class='ruby-doc
remote' target='_blank'>Rational Reference</a>



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

<a href='https://ruby-doc.org/core-2.5.0/Complex.html' class='ruby-doc
remote' target='_blank'>Complex Reference</a>



## BigDecimal



*Part of standard library. You need to `require 'bigdecimal'` before
using.*

Ruby provides built-in support for arbitrary precision integer
arithmetic.

For example:


```ruby
42**13  #=>   1265437718438866624512
```

BigDecimal provides similar support for very large or very accurate
floating point numbers.

Decimal arithmetic is also useful for general calculation, because it
provides the correct answers people expect--whereas normal binary
floating point arithmetic often introduces subtle errors because of the
conversion between base 10 and base 2.

For example, try:


```ruby
sum = 0
10_000.times do
  sum = sum + 0.0001
end
print sum #=> 0.9999999999999062
```

and contrast with the output from:


```ruby
require 'bigdecimal'

sum = BigDecimal("0")
10_000.times do
  sum = sum + BigDecimal("0.0001")
end
print sum #=> 0.1E1
```

Similarly:


```ruby
(BigDecimal("1.2") - BigDecimal("1.0")) == BigDecimal("0.2") #=> true

(1.2 - 1.0) == 0.2 #=> false
```

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/bigdecimal/rdoc/BigDecimal.html'
class='ruby-doc remote' target='_blank'>BigDecimal Reference</a>



## Number Utilities



### Math

The Math module contains module functions for basic trigonometric and
transcendental functions. See class Float for a list of constants that
define Ruby's floating point accuracy.

Domains and codomains are given only for real (not complex) numbers.

<a href='https://ruby-doc.org/core-2.5.0/Math.html' class='ruby-doc
remote' target='_blank'>Math Reference</a>



### Prime

*Part of standard library. You need to `require 'prime'` before using.*

The set of all prime numbers.

#### Example


```ruby
Prime.each(100) do |prime|
  p prime  #=> 2, 3, 5, 7, 11, ...., 97
end
```

Prime is Enumerable:


```ruby
Prime.first 5 # => [2, 3, 5, 7, 11]
```

#### Retrieving the instance

For convenience, each instance method of `Prime.instance` can be
accessed as a class method of `Prime`.

e.g.


```ruby
Prime.instance.prime?(2)  #=> true
Prime.prime?(2)           #=> true
```

#### Generators

A "generator" provides an implementation of enumerating pseudo-prime
numbers and it remembers the position of enumeration and upper bound.
Furthermore, it is an external iterator of prime enumeration which is
compatible with an Enumerator.

`Prime::PseudoPrimeGenerator` is the base class for generators. There
are few implementations of generator.

* `Prime::EratosthenesGenerator`: Uses eratosthenes' sieve.
* `Prime::TrialDivisionGenerator`: Uses the trial division method.
* `Prime::Generator23`: Generates all positive integers which are not
  divisible by either 2 or 3. This sequence is very bad as a
  pseudo-prime sequence. But this is faster and uses much less memory
  than the other generators. So, it is suitable for factorizing an
  integer which is not large but has many prime factors. e.g. for
  Prime#prime? .

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/prime/rdoc/Prime.html'
class='ruby-doc remote' target='_blank'>Prime Reference</a>

