---
title: 'ripper: Parsing Ruby'
prev: "/stdlib/development/profiler.html"
next: "/stdlib/development/tracer.html"
---


```ruby
require 'ripper'
```

## Ripper

Ripper is a Ruby script parser.

You can get information from the parser with event-based style.
Information such as abstract syntax trees or simple lexical analysis of
the Ruby program.

### Usage

Ripper provides an easy interface for parsing your program into a
symbolic expression tree (or S-expression).

Understanding the output of the parser may come as a challenge, it's
recommended you use PP to format the output for legibility.


```
require 'ripper'
require 'pp'

pp Ripper.sexp('def hello(world) "Hello, #{world}!"; end')
  #=> [:program,
       [[:def,
         [:@ident, "hello", [1, 4]],
         [:paren,
          [:params, [[:@ident, "world", [1, 10]]], nil, nil, nil, nil, nil, nil]],
         [:bodystmt,
          [[:string_literal,
            [:string_content,
             [:@tstring_content, "Hello, ", [1, 18]],
             [:string_embexpr, [[:var_ref, [:@ident, "world", [1, 27]]]]],
             [:@tstring_content, "!", [1, 33]]]]],
          nil,
          nil,
          nil]]]]
```

You can see in the example above, the expression starts with `:program`.

From here, a method definition at `:def`, followed by the method's
identifier `:@ident`. After the method's identifier comes the
parentheses `:paren` and the method parameters under `:params`.

Next is the method body, starting at `:bodystmt` (`stmt` meaning
statement), which contains the full definition of the method.

In our case, we're simply returning a String, so next we have the
`:string_literal` expression.

Within our `:string_literal` you'll notice two `@tstring_content`, this
is the literal part for `Hello, ` and `!`. Between the two
`@tstring_content` statements is a `:string_embexpr`, where *embexpr* is
an embedded expression. Our expression consists of a local variable, or
`var_ref`, with the identifier (`@ident`) of `world`.

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/ripper/rdoc/Ripper.html'
class='ruby-doc remote' target='_blank'>Ripper Reference</a>

