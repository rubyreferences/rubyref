# Precedence

From highest to lowest, this is the precedence table for ruby. High
precedence operations happen before low precedence operations.


```
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
```

Unary `+` and unary `-` are for `+1`, `-1` or `-(a + b)`.

Modifier-if, modifier-unless, etc. are for the modifier versions of
those keywords. For example, this is a modifier-unless expression:


```ruby
a += 1 unless a.zero?
```

`{ ... }` blocks have priority below all listed operations, but `do ...
end` blocks have lower priority.

All other words in the precedence table above are keywords.

