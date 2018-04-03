---
title: Assignment
prev: "/language/variables-constants.html"
next: "/language/control-expressions.html"
---

# Assignment

In Ruby, assignment uses the `=` (equals sign) character. This example
assigns the number five to the local variable `v`: 

```ruby
v = 5
```

Assignment creates a local variable if the variable was not previously
referenced.

## Abbreviated Assignment

You can mix several of the operators and assignment. To add 1 to an
object you can write:


```ruby
a = 1

a += 2

p a # prints 3
```

This is equivalent to:


```ruby
a = 1

a = a + 2

p a # prints 3
```

You can use the following operators this way: `+`, `-`, `*`, `/`, `%`,
`**`, `&`, `|`, `^`, `<<`, `>>`

There are also `||=` and `&&=`. The former makes an assignment if the
value was `nil` or `false` while the latter makes an assignment if the
value was not `nil` or `false`.

Here is an example:


```ruby
a ||= 0
a &&= 1

p a # prints 1
```

Note that these two operators behave more like `a || a = 0` than `a = a
|| 0`.

## Multiple Assignment

You can assign multiple values on the right-hand side to multiple
variables:


```ruby
a, b = 1, 2

p a: a, b: b # prints {:a=>1, :b=>2}
```

In the following sections any place "variable" is used an assignment
method, instance, class or global will also work:


```ruby
def value=(value)
  p assigned: value
end

self.value, $global = 1, 2 # prints {:assigned=>1}

p $global # prints 2
```

You can use multiple assignment to swap two values in-place:


```ruby
old_value = 1

new_value, old_value = old_value, 2

p new_value: new_value, old_value: old_value
# prints {:new_value=>1, :old_value=>2}
```

If you have more values on the right hand side of the assignment than
variables on the left hand side, the extra values are ignored:


```ruby
a, b = 1, 2, 3

p a: a, b: b # prints {:a=>1, :b=>2}
```

You can use `*` to gather extra values on the right-hand side of the
assignment.


```ruby
a, *b = 1, 2, 3

p a: a, b: b # prints {:a=>1, :b=>[2, 3]}
```

The `*` can appear anywhere on the left-hand side:


```ruby
*a, b = 1, 2, 3

p a: a, b: b # prints {:a=>[1, 2], :b=>3}
```

But you may only use one `*` in an assignment.

## Array Decomposition

Like Array decomposition in <a href='/language/methods-def.md'
class='remote' target='_blank'>method arguments</a> you can decompose an
Array during assignment using parenthesis:


```ruby
(a, b) = [1, 2]

p a: a, b: b # prints {:a=>1, :b=>2}
```

You can decompose an Array as part of a larger multiple assignment:


```ruby
a, (b, c) = 1, [2, 3]

p a: a, b: b, c: c # prints {:a=>1, :b=>2, :c=>3}
```

Since each decomposition is considered its own multiple assignment you
can use `*` to gather arguments in the decomposition:


```ruby
a, (b, *c), *d = 1, [2, 3, 4], 5, 6

p a: a, b: b, c: c, d: d
# prints {:a=>1, :b=>2, :c=>[3, 4], :d=>[5, 6]}
```

