# Precedence

From highest to lowest, this is the precedence table for ruby.  High
precedence operations happen before low precedence operations.

    !, ~, unary +

    **

    unary -

    *, /, %

    +, -

    <<, >>

    &

    |, ^

    >, >=, <, <=

    <=>, ==, ===, !=, =~, !~

    &&

    ||

    .., ...

    ?, :

    modifier-rescue

    =, +=, -=, etc.

    defined?

    not

    or, and

    modifier-if, modifier-unless, modifier-while, modifier-until

    { } blocks

Unary `+` and unary `-` are for `+1`, `-1` or `-(a + b)`.

Modifier-if, modifier-unless, etc. are for the modifier versions of those
keywords.  For example, this is a modifier-unless statement:

    a += 1 unless a.zero?

Note that `(a if b rescue c)` is parsed as `((a if b) rescue c)` due to
reasons not related to precedence. See [modifier
statements](control_expressions_rdoc.html#label-Modifier+Statements).

`{ ... }` blocks have priority below all listed operations, but `do ... end`
blocks have lower priority.

All other words in the precedence table above are keywords.