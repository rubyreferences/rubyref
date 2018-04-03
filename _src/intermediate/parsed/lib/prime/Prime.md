# Prime

The set of all prime numbers.

## Example

    Prime.each(100) do |prime|
      p prime  #=> 2, 3, 5, 7, 11, ...., 97
    end

Prime is Enumerable:

    Prime.first 5 # => [2, 3, 5, 7, 11]

## Retrieving the instance

For convenience, each instance method of `Prime`.instance can be accessed as a
class method of `Prime`.

e.g.
    Prime.instance.prime?(2)  #=> true
    Prime.prime?(2)           #=> true

## Generators

A "generator" provides an implementation of enumerating pseudo-prime numbers
and it remembers the position of enumeration and upper bound. Furthermore, it
is an external iterator of prime enumeration which is compatible with an
Enumerator.

`Prime`::`PseudoPrimeGenerator` is the base class for generators. There are
few implementations of generator.

`Prime`::`EratosthenesGenerator`
:   Uses eratosthenes' sieve.
`Prime`::`TrialDivisionGenerator`
:   Uses the trial division method.
`Prime`::`Generator23`
:   Generates all positive integers which are not divisible by either 2 or 3.
    This sequence is very bad as a pseudo-prime sequence. But this is faster
    and uses much less memory than the other generators. So, it is suitable
    for factorizing an integer which is not large but has many prime factors.
    e.g. for Prime#prime? .


[Prime Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/prime/rdoc/Prime.html)
