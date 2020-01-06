---
title: 'did_you_mean: Typo suggestions'
prev: "/stdlib/string-utilities/strscan.html"
next: "/stdlib/networking-web.html"
---


```ruby
require 'did_you_mean'
```

## DidYouMean[](#didyoumean)

The `DidYouMean` gem adds functionality to suggest possible method/class
names upon errors such as `NameError` and `NoMethodError`. In Ruby 2.3
or later, it is automatically activated during startup.


```ruby
methosd
# => NameError: undefined local variable or method `methosd` for main:Object
#   Did you mean?  methods
#                  method

OBject
# => NameError: uninitialized constant OBject
#    Did you mean?  Object

@full_name = "Yuki Nishijima"
first_name, last_name = full_name.split(" ")
# => NameError: undefined local variable or method `full_name` for main:Object
#    Did you mean?  @full_name

@@full_name = "Yuki Nishijima"
@@full_anme
# => NameError: uninitialized class variable @@full_anme in Object
#    Did you mean?  @@full_name

full_name = "Yuki Nishijima"
full_name.starts_with?("Y")
# => NoMethodError: undefined method `starts_with?` for "Yuki Nishijima":String
#    Did you mean?  start_with?

hash = {foo: 1, bar: 2, baz: 3}
hash.fetch(:fooo)
# => KeyError: key not found: :fooo
#    Did you mean?  :foo
```

### Disabling `did_you_mean`[](#disabling-didyoumean)

Occasionally, you may want to disable the `did_you_mean` gem for e.g.
debugging issues in the error object itself. You can disable it entirely
by specifying `--disable-did_you_mean` option to the `ruby` command:


```
$ ruby --disable-did_you_mean -e "1.zeor?"
-e:1:in `<main>': undefined method `zeor?` for 1:Integer (NameError)
```

When you do not have direct access to the `ruby` command (e.g. +rails
console+, `irb`), you could applyoptions using the `RUBYOPT` environment
variable:


```
$ RUBYOPT='--disable-did_you_mean' irb
irb:0> 1.zeor?
# => NoMethodError (undefined method `zeor?` for 1:Integer)
```

### Getting the original error message[](#getting-the-original-error-message)

Sometimes, you do not want to disable the gem entirely, but need to get
the original error message without suggestions (e.g. testing). In this
case, you could use the `#original_message` method on the error object:


```ruby
no_method_error = begin
                    1.zeor?
                  rescue NoMethodError => error
                    error
                  end

no_method_error.message
# => NoMethodError (undefined method `zeor?` for 1:Integer)
#    Did you mean?  zero?

no_method_error.original_message
# => NoMethodError (undefined method `zeor?` for 1:Integer)
```

<a
href='https://ruby-doc.org/stdlib-2.7.0/libdoc/did_you_mean/rdoc/DidYouMean.html'
class='ruby-doc remote' target='_blank'>DidYouMean Reference</a>

