# Shellwords

This module manipulates strings according to the word parsing rules of
the UNIX Bourne shell.

You can use Shellwords to parse a string into a Bourne shell friendly
Array.


```ruby
require 'shellwords'

argv = Shellwords.split('three blind "mice"')
argv #=> ["three", "blind", "mice"]
```

Once you've required Shellwords, you can use the `#split` alias
String#shellsplit.


```ruby
argv = "see how they run".shellsplit
argv #=> ["see", "how", "they", "run"]
```

Be careful you don't leave a quote unmatched.


```ruby
argv = "they all ran after the farmer's wife".shellsplit
     #=> ArgumentError: Unmatched double quote: ...
```

In this case, you might want to use Shellwords.escape, or its alias
String#shellescape.

This method will escape the String for you to safely use with a Bourne
shell.


```ruby
argv = Shellwords.escape("special's.txt")
argv #=> "special\\'s.txt"
system("cat " + argv)
```

Shellwords also comes with a core extension for Array,
`Array#shelljoin`.


```ruby
argv = %w{ls -lta lib}
system(argv.shelljoin)
```

You can use this method to create an escaped string out of an array of
tokens separated by a space. In this example we used the literal
shortcut for Array.new.

[Shellwords
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/shellwords/rdoc/Shellwords.html)

