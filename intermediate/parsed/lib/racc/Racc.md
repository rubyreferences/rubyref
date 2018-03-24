# Racc

Racc is a LALR(1) parser generator. It is written in Ruby itself, and
generates Ruby programs.

## Command-line Reference

    racc [-o<var>filename</var>] [--output-file=<var>filename</var>]
         [-e<var>rubypath</var>] [--embedded=<var>rubypath</var>]
         [-v] [--verbose]
         [-O<var>filename</var>] [--log-file=<var>filename</var>]
         [-g] [--debug]
         [-E] [--embedded]
         [-l] [--no-line-convert]
         [-c] [--line-convert-all]
         [-a] [--no-omit-actions]
         [-C] [--check-only]
         [-S] [--output-status]
         [--version] [--copyright] [--help] <var>grammarfile</var>

`filename`
:   Racc grammar file. Any extension is permitted.
-o+outfile+, --output-file=`outfile`
:   A filename for output. default is <`filename`>.tab.rb
-O+filename+, --log-file=`filename`
:   Place logging output in file `filename`. Default log file name is
    <`filename`>.output.
-e+rubypath+, --executable=`rubypath`
:   output executable file(mode 755). where `path` is the Ruby interpreter.
-v, --verbose
:   verbose mode. create `filename`.output file, like yacc's y.output file.
-g, --debug
:   add debug code to parser class. To display debugging information, use this
    '-g' option and set @yydebug true in parser class.
-E, --embedded
:   Output parser which doesn't need runtime files (racc/parser.rb).
-C, --check-only
:   Check syntax of racc grammar file and quit.
-S, --output-status
:   Print messages time to time while compiling.
-l, --no-line-convert
:   turns off line number converting.
-c, --line-convert-all
:   Convert line number of actions, inner, header and footer.
-a, --no-omit-actions
:   Call all actions, even if an action is empty.
--version
:   print Racc version and quit.
--copyright
:   Print copyright and quit.
--help
:   Print usage and quit.


## Generating Parser Using Racc

To compile Racc grammar file, simply type:

    $ racc parse.y

This creates Ruby script file "parse.tab.y". The -o option can change the
output filename.

## Writing A Racc Grammar File

If you want your own parser, you have to write a grammar file. A grammar file
contains the name of your parser class, grammar for the parser, user code, and
anything else. When writing a grammar file, yacc's knowledge is helpful. If
you have not used yacc before, Racc is not too difficult.

Here's an example Racc grammar file.

    class Calcparser
    rule
      target: exp { print val[0] }

      exp: exp '+' exp
         | exp '*' exp
         | '(' exp ')'
         | NUMBER
    end

Racc grammar files resemble yacc files. But (of course), this is Ruby code.
yacc's $$ is the 'result', $0, $1... is an array called 'val', and $-1, $-2...
is an array called '_values'.

See the [Grammar File Reference](rdoc-ref:lib/racc/rdoc/grammar.en.rdoc) for
more information on grammar files.

## Parser

Then you must prepare the parse entry method. There are two types of parse
methods in Racc, Racc::Parser#do_parse and Racc::Parser#yyparse

Racc::Parser#do_parse is simple.

It's yyparse() of yacc, and Racc::Parser#next_token is yylex(). This method
must returns an array like [TOKENSYMBOL, ITS_VALUE]. EOF is [false, false].
(TOKENSYMBOL is a Ruby symbol (taken from String#intern) by default. If you
want to change this, see the grammar reference.

Racc::Parser#yyparse is little complicated, but useful. It does not use
Racc::Parser#next_token, instead it gets tokens from any iterator.

For example, `yyparse(obj, :scan)` causes calling +obj#scan+, and you can
return tokens by yielding them from +obj#scan+.

## Debugging

When debugging, "-v" or/and the "-g" option is helpful.

"-v" creates verbose log file (.output). "-g" creates a "Verbose Parser".
Verbose Parser prints the internal status when parsing. But it's *not*
automatic. You must use -g option and set +@yydebug+ to `true` in order to get
output. -g option only creates the verbose parser.

### Racc reported syntax error.

Isn't there too many "end"? grammar of racc file is changed in v0.10.

Racc does not use '%' mark, while yacc uses huge number of '%' marks..

### Racc reported "XXXX conflicts".

Try "racc -v xxxx.y". It causes producing racc's internal log file,
xxxx.output.

### Generated parsers does not work correctly

Try "racc -g xxxx.y". This command let racc generate "debugging parser". Then
set @yydebug=true in your parser. It produces a working log of your parser.

## Re-distributing Racc runtime

A parser, which is created by Racc, requires the Racc runtime module;
racc/parser.rb.

Ruby 1.8.x comes with Racc runtime module, you need NOT distribute Racc
runtime files.

If you want to include the Racc runtime module with your parser. This can be
done by using '-E' option:

    $ racc -E -omyparser.rb myparser.y

This command creates myparser.rb which `includes' Racc runtime. Only you must
do is to distribute your parser file (myparser.rb).

Note: parser.rb is LGPL, but your parser is not. Your own parser is completely
yours.

[Racc Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/racc/rdoc/Racc.html)
