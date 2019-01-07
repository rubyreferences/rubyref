# RDoc

RDoc produces documentation for Ruby source files by parsing the source and
extracting the definition for classes, modules, methods, includes and
requires.  It associates these with optional documentation contained in an
immediately preceding comment block then renders the result using an output
formatter.

For a simple introduction to writing or generating documentation using RDoc
see the README.

## Roadmap

If you think you found a bug in RDoc see CONTRIBUTING@Bugs

If you want to use RDoc to create documentation for your Ruby source files,
see RDoc::Markup and refer to `rdoc --help` for command line usage.

If you want to set the default markup format see
RDoc::Markup@Supported+Formats

If you want to store rdoc configuration in your gem (such as the default
markup format) see RDoc::Options@Saved+Options

If you want to write documentation for Ruby files see RDoc::Parser::Ruby

If you want to write documentation for extensions written in C see
RDoc::Parser::C

If you want to generate documentation using `rake` see RDoc::Task.

If you want to drive RDoc programmatically, see RDoc::RDoc.

If you want to use the library to format text blocks into HTML or other
formats, look at RDoc::Markup.

If you want to make an RDoc plugin such as a generator or directive handler
see RDoc::RDoc.

If you want to write your own output generator see RDoc::Generator.

If you want an overview of how RDoc works see CONTRIBUTING

## Credits

RDoc is currently being maintained by Eric Hodel <drbrain@segment7.net>.

Dave Thomas <dave@pragmaticprogrammer.com> is the original author of RDoc.

*   The Ruby parser in rdoc/parse.rb is based heavily on the outstanding work
    of Keiju ISHITSUKA of Nippon Rational Inc, who produced the Ruby parser
    for irb and the rtags package.


[RDoc Reference](https://ruby-doc.org/stdlib-2.6/libdoc/rdoc/rdoc/RDoc.html)