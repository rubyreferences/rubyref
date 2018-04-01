---
title: Documenting Ruby Code
prev: "/developing/libraries.html"
next: "/developing/testing.html"
---

# Documenting Ruby Code

Ruby Standard Library includes [RDoc](https://ruby.github.io/rdoc/) tool
for generating code documentation from comments. Here is an example of
RDoc documentation format, taken from its README:


```ruby
##
# This class represents an arbitrary shape by a series of points.

class Shape

  ##
  # Creates a new shape described by a +polyline+.
  #
  # If the +polyline+ does not end at the same point it started at the
  # first pointed is copied and placed at the end of the line.
  #
  # An ArgumentError is raised if the line crosses itself, but shapes may
  # be concave.

  def initialize polyline
    # ...
  end

end
```

Another popular Ruby documentation tool is [YARD](https://yardoc.org/).
It supports RDoc format, and also provides more formalized approach,
with tags specifying various aspects of documentation. Here is an
example of YARD documentation format, taken from its README:


```ruby
# Reverses the contents of a String or IO object.
#
# @param [String, #read] contents the contents to reverse
# @return [String] the contents reversed lexically
def reverse(contents)
  contents = contents.read if contents.respond_to? :read
  contents.reverse
end
```

