---
title: Random
prev: "/builtin/marshal.html"
next: "/stdlib.html"
---

## Random[](#random)

Random provides an interface to Ruby's pseudo-random number generator,
or PRNG. The PRNG produces a deterministic sequence of bits which
approximate true randomness. The sequence may be represented by
integers, floats, or binary strings.

The generator may be initialized with either a system-generated or
user-supplied seed value by using Random.srand.

The class method Random.rand provides the base functionality of
Kernel.rand along with better handling of floating point values. These
are both interfaces to Random::DEFAULT, the Ruby system PRNG.

Random.new will create a new PRNG with a state independent of
Random::DEFAULT, allowing multiple generators with different seed values
or sequence positions to exist simultaneously. Random objects can be
marshaled, allowing sequences to be saved and resumed.

PRNGs are currently implemented as a modified Mersenne Twister with a
period of 2\*\*19937-1.

<a href='https://ruby-doc.org/core-2.5.0/Random.html' class='ruby-doc
remote' target='_blank'>Random Reference</a>



### SecureRandom[](#securerandom)

*Part of standard library. You need to `require 'securerandom'` before
using.*

This library is an interface to secure random number generators which
are suitable for generating session keys in HTTP cookies, etc.

You can use this library in your application by requiring it:


```ruby
require 'securerandom'
```

It supports the following secure random number generators:

* openssl
* /dev/urandom
* Win32

##### Examples[](#examples)

Generate random hexadecimal strings:


```ruby
require 'securerandom'

p SecureRandom.hex(10) #=> "52750b30ffbc7de3b362"
p SecureRandom.hex(10) #=> "92b15d6c8dc4beb5f559"
p SecureRandom.hex(13) #=> "39b290146bea6ce975c37cfc23"
```

Generate random base64 strings:


```ruby
p SecureRandom.base64(10) #=> "EcmTPZwWRAozdA=="
p SecureRandom.base64(10) #=> "KO1nIU+p9DKxGg=="
p SecureRandom.base64(12) #=> "7kJSM/MzBJI+75j8"
```

Generate random binary strings:


```ruby
p SecureRandom.random_bytes(10) #=> "\016\t{\370g\310pbr\301"
p SecureRandom.random_bytes(10) #=> "\323U\030TO\234\357\020\a\337"
```

Generate UUIDs:


```ruby
p SecureRandom.uuid #=> "2d931510-d99f-494a-8c67-87feb05e1594"
p SecureRandom.uuid #=> "bad85eb9-0713-4da7-8d36-07a8e4b00eab"
```

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/securerandom/rdoc/SecureRandom.html'
class='ruby-doc remote' target='_blank'>SecureRandom Reference</a>

