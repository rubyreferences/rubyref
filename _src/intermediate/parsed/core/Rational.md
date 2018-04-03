# Rational

A rational number can be represented as a pair of integer numbers: a/b (b>0),
where a is the numerator and b is the denominator. Integer a equals rational
a/1 mathematically.

In Ruby, you can create rational objects with the Kernel#Rational, to_r, or
rationalize methods or by suffixing `r` to a literal. The return values will
be irreducible fractions.

    Rational(1)      #=> (1/1)
    Rational(2, 3)   #=> (2/3)
    Rational(4, -6)  #=> (-2/3)
    3.to_r           #=> (3/1)
    2/3r             #=> (2/3)

You can also create rational objects from floating-point numbers or strings.

    Rational(0.3)    #=> (5404319552844595/18014398509481984)
    Rational('0.3')  #=> (3/10)
    Rational('2/3')  #=> (2/3)

    0.3.to_r         #=> (5404319552844595/18014398509481984)
    '0.3'.to_r       #=> (3/10)
    '2/3'.to_r       #=> (2/3)
    0.3.rationalize  #=> (3/10)

A rational object is an exact number, which helps you to write programs
without any rounding errors.

    10.times.inject(0) {|t| t + 0.1 }              #=> 0.9999999999999999
    10.times.inject(0) {|t| t + Rational('0.1') }  #=> (1/1)

However, when an expression includes an inexact component (numerical value or
operation), it will produce an inexact result.

    Rational(10) / 3   #=> (10/3)
    Rational(10) / 3.0 #=> 3.3333333333333335

    Rational(-8) ** Rational(1, 3)
                       #=> (1.0000000000000002+1.7320508075688772i)

[Rational Reference](http://ruby-doc.org/core-2.5.0/Rational.html)
