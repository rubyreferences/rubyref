# BigDecimal

BigDecimal provides arbitrary-precision floating point decimal arithmetic.

## Introduction

Ruby provides built-in support for arbitrary precision integer arithmetic.

For example:

    42**13  #=>   1265437718438866624512

BigDecimal provides similar support for very large or very accurate floating
point numbers.

Decimal arithmetic is also useful for general calculation, because it provides
the correct answers people expect--whereas normal binary floating point
arithmetic often introduces subtle errors because of the conversion between
base 10 and base 2.

For example, try:

    sum = 0
    10_000.times do
      sum = sum + 0.0001
    end
    print sum #=> 0.9999999999999062

and contrast with the output from:

    require 'bigdecimal'

    sum = BigDecimal("0")
    10_000.times do
      sum = sum + BigDecimal("0.0001")
    end
    print sum #=> 0.1E1

Similarly:

    (BigDecimal("1.2") - BigDecimal("1.0")) == BigDecimal("0.2") #=> true

    (1.2 - 1.0) == 0.2 #=> false

## Special features of accurate decimal arithmetic

Because BigDecimal is more accurate than normal binary floating point
arithmetic, it requires some special values.

### Infinity

BigDecimal sometimes needs to return infinity, for example if you divide a
value by zero.

    BigDecimal("1.0") / BigDecimal("0.0")  #=> Infinity
    BigDecimal("-1.0") / BigDecimal("0.0")  #=> -Infinity

You can represent infinite numbers to BigDecimal using the strings
`'Infinity'`, `'+Infinity'` and `'-Infinity'` (case-sensitive)

### Not a Number

When a computation results in an undefined value, the special value `NaN` (for
'not a number') is returned.

Example:

    BigDecimal("0.0") / BigDecimal("0.0") #=> NaN

You can also create undefined values.

NaN is never considered to be the same as any other value, even NaN itself:

    n = BigDecimal('NaN')
    n == 0.0 #=> false
    n == n #=> false

### Positive and negative zero

If a computation results in a value which is too small to be represented as a
BigDecimal within the currently specified limits of precision, zero must be
returned.

If the value which is too small to be represented is negative, a BigDecimal
value of negative zero is returned.

    BigDecimal("1.0") / BigDecimal("-Infinity") #=> -0.0

If the value is positive, a value of positive zero is returned.

    BigDecimal("1.0") / BigDecimal("Infinity") #=> 0.0

(See BigDecimal.mode for how to specify limits of precision.)

Note that `-0.0` and `0.0` are considered to be the same for the purposes of
comparison.

Note also that in mathematics, there is no particular concept of negative or
positive zero; true mathematical zero has no sign.

## bigdecimal/util

When you require `bigdecimal/util`, the `#to_d` method will be available on
BigDecimal and the native Integer, Float, Rational, and String classes:

    require 'bigdecimal/util'

    42.to_d         # => 0.42e2
    0.5.to_d        # => 0.5e0
    (2/3r).to_d(3)  # => 0.667e0
    "0.5".to_d      # => 0.5e0

## License

Copyright (C) 2002 by Shigeo Kobayashi <shigeo@tinyforest.gr.jp>.

BigDecimal is released under the Ruby and 2-clause BSD licenses. See
LICENSE.txt for details.

Maintained by mrkn <mrkn@mrkn.jp> and ruby-core members.

Documented by zzak <zachary@zacharyscott.net>, mathew <meta@pobox.com>, and
many other contributors.

[BigDecimal Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/bigdecimal/rdoc/BigDecimal.html)