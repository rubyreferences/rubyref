# Shellwords

## Manipulates strings like the UNIX Bourne shell

This module manipulates strings according to the word parsing rules of the
UNIX Bourne shell.

The shellwords() function was originally a port of shellwords.pl, but modified
to conform to the Shell & Utilities volume of the IEEE Std 1003.1-2008, 2016
Edition [1].

### Usage

You can use Shellwords to parse a string into a Bourne shell friendly Array.

    require 'shellwords'

    argv = Shellwords.split('three blind "mice"')
    argv #=> ["three", "blind", "mice"]

Once you've required Shellwords, you can use the `#split` alias
`String#shellsplit`.

    argv = "see how they run".shellsplit
    argv #=> ["see", "how", "they", "run"]

Be careful you don't leave a quote unmatched.

    argv = "they all ran after the farmer's wife".shellsplit
         #=> ArgumentError: Unmatched double quote: ...

In this case, you might want to use Shellwords.escape, or its alias
`String#shellescape`.

This method will escape the String for you to safely use with a Bourne shell.

    argv = Shellwords.escape("special's.txt")
    argv #=> "special\\'s.txt"
    system("cat " + argv)

Shellwords also comes with a core extension for Array, `Array#shelljoin`.

    argv = %w{ls -lta lib}
    system(argv.shelljoin)

You can use this method to create an escaped string out of an array of tokens
separated by a space. In this example we used the literal shortcut for
Array.new.

### Authors

*   Wakou Aoyama
*   Akinori MUSHA <knu@iDaemons.org>


### Contact

*   Akinori MUSHA <knu@iDaemons.org> (current maintainer)


### Resources

1: [IEEE Std 1003.1-2008, 2016 Edition, the Shell & Utilities
volume](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/contents.htm
l)

[Shellwords Reference](https://ruby-doc.org/stdlib-2.7.0/libdoc/shellwords/rdoc/Shellwords.html)