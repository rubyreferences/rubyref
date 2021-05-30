# Random

Random provides an interface to Ruby's pseudo-random number generator, or
PRNG.  The PRNG produces a deterministic sequence of bits which approximate
true randomness. The sequence may be represented by integers, floats, or
binary strings.

The generator may be initialized with either a system-generated or
user-supplied seed value by using Random.srand.

The class method Random.rand provides the base functionality of Kernel.rand
along with better handling of floating point values. These are both interfaces
to Random::DEFAULT, the Ruby system PRNG.

Random.new will create a new PRNG with a state independent of Random::DEFAULT,
allowing multiple generators with different seed values or sequence positions
to exist simultaneously. Random objects can be marshaled, allowing sequences
to be saved and resumed.

PRNGs are currently implemented as a modified Mersenne Twister with a period
of 2**19937-1.

[Random Reference](https://ruby-doc.org/core-2.7.0/Random.html)