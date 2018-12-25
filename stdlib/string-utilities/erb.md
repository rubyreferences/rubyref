---
title: 'erb: Ruby Templating'
prev: "/stdlib/string-utilities.html"
next: "/stdlib/string-utilities/racc.html"
---


```ruby
require 'erb'
```

### ERB[](#erb)



ERB provides an easy to use but powerful templating system for Ruby.
Using ERB, actual Ruby code can be added to any plain text document for
the purposes of generating document information details and/or flow
control.

A very simple example is this:


```ruby
require 'erb'

x = 42
template = ERB.new <<-EOF
  The value of x is: <%= x %>
EOF
puts template.result(binding)
```

*Prints:* The value of x is: 42

More complex examples are given below.

#### Recognized Tags[](#recognized-tags)

ERB recognizes certain tags in the provided template and converts them
based on the rules below:


```
<% Ruby code -- inline with output %>
<%= Ruby expression -- replace with result %>
<%# comment -- ignored -- useful in testing %>
% a line of Ruby code -- treated as <% line %> (optional -- see ERB.new)
%% replaced with % if first thing on a line and % processing is used
<%% or %%> -- replace with <% or %> respectively
```

All other text is passed through ERB filtering unchanged.

#### Options[](#options)

There are several settings you can change when you use ERB:

* the nature of the tags that are recognized;
* the value of `$SAFE` under which the template is run;
* the binding used to resolve local variables in the template.

See the ERB.new and `ERB#result` methods for more detail.

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/erb/rdoc/ERB.html'
class='ruby-doc remote' target='_blank'>ERB Reference</a>

