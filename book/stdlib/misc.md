# Prime

The set of all prime numbers.

## Example


```ruby
Prime.each(100) do |prime|
  p prime  #=> 2, 3, 5, 7, 11, ...., 97
end
```

Prime is Enumerable:


```ruby
Prime.first 5 # => [2, 3, 5, 7, 11]
```

## Retrieving the instance

For convenience, each instance method of `Prime`.instance can be
accessed as a class method of `Prime`.

e.g. Prime.instance.prime?(2) #=> true Prime.prime?(2) #=> true

## Generators

A "generator" provides an implementation of enumerating pseudo-prime
numbers and it remembers the position of enumeration and upper bound.
Furthermore, it is an external iterator of prime enumeration which is
compatible with an Enumerator.

`Prime`\::`PseudoPrimeGenerator` is the base class for generators. There
are few implementations of generator.

`Prime`\::`EratosthenesGenerator`
: Uses eratosthenes' sieve. `Prime`\::`TrialDivisionGenerator`
: Uses the trial division method. `Prime`\::`Generator23`
: Generates all positive integers which are not divisible by either 2 or
  3. This sequence is very bad as a pseudo-prime sequence. But this is
  faster and uses much less memory than the other generators. So, it is
  suitable for factorizing an integer which is not large but has many
  prime factors. e.g. for Prime#prime? .



## SecureRandom

### Secure random number generator interface.

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

#### Examples

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



## Timeout::TimeoutError

Raised by Timeout.timeout when the block times out.



## Timeout

Timeout long-running blocks

### Synopsis


```ruby
require 'timeout'
status = Timeout::timeout(5) {
  # Something that should be interrupted if it takes more than 5 seconds...
}
```

### Description

Timeout provides a way to auto-terminate a potentially long-running
operation if it hasn't finished in a fixed amount of time.

Previous versions didn't use a module for namespacing, however #timeout
is provided for backwards compatibility. You should prefer
Timeout.timeout instead.

### Copyright

Copyright
: (C) 2000 Network Applied Communication Laboratory, Inc. Copyright
: (C) 2000 Information-technology Promotion Agency, Japan

