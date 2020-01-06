---
title: Comments
prev: "/language/literals.html"
next: "/language/variables-constants.html"
---

## Code Comments[](#code-comments)

Ruby has two types of comments: inline and block.

Inline comments start with the `#` character and continue until the end of the line:


```ruby
# On a separate line
class Foo # or at the end of the line
  # can be indented
  def bar
  end
end
```

Block comments start with `=begin` and end with `=end`. Each should start on a separate line.


```ruby
=begin
This is
commented out
=end

class Foo
end

=begin some_tag
this works, too
=end
```

`=begin` and `=end` can not be indented, so this is a syntax error:


```
class Foo
  =begin
  Will not work
  =end
end
```



#### Comments as documentation[](#comments-as-documentation)

The Ruby standard library includes the [RDoc](../developing/documenting.md) tool for generating documentation from code. RDoc format is "unobtrusive" (plain text) documentation. Ruby gem <a href='https://yardoc.org/' class='remote' target='_blank'>YARD</a> is also frequently used to generate documentation, providing a more strict format allowing rendering of "tags" (param types, return type, examples and so on).

