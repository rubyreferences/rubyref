# -*- mode: rdoc; coding: utf-8; fill-column: 74; -*-

## Pre-defined variables

$!
: The exception information message set by 'raise'. $@
: Array of backtrace of the last exception thrown. $&
: The string matched by the last successful match. $\`
: The string to the left of the last successful match. $'
: The string to the right of the last successful match. $+
: The highest group matched by the last successful match. $1
: The Nth group of the last successful match. May be > 1. $~
: The information about the last match in the current scope. $=
: This variable is no longer effective. Deprecated. $/
: The input record separator, newline by default. $\\
: The output record separator for the print and IO#write. Default is
  nil. $,
: The output field separator for the print and Array#join. $;
: The default separator for String#split. $.
: The current input line number of the last file that was read. $<
: The virtual concatenation file of the files given on command line (or
  from $stdin if no files were given). $>
: The default output for print, printf. $stdout by default. $\_
: The last input line of string by gets or readline. $0
: Contains the name of the script being executed. May be assignable. $\*
: Command line arguments given for the script sans args. \$$
: The process number of the Ruby running this script. $?
: The status of the last executed child process. This value is
  thread-local. $:
: Load path for scripts and binary modules by load or require. $"
: The array contains the module names loaded by require. $DEBUG
: The debug flag, which is set by the -d switch. Enabling debug output
  prints each exception raised to $stderr (but not its backtrace).
  Setting this to a true value enables debug output as if -d were given
  on the command line. Setting this to a false value disables debug
  output. $LOADED\_FEATURES
: The alias to the $". $FILENAME
: Current input file from $<. Same as $<.filename. $LOAD\_PATH
: The alias to the $:. $stderr
: The current standard error output. $stdin
: The current standard input. $stdout
: The current standard output. $VERBOSE
: The verbose flag, which is set by the -w or -v switch. Setting this to
  a true value enables warnings as if -w or -v were given on the command
  line. Setting this to nil disables warnings, including from
  Kernel#warn. $-0
: The alias to $/. $-a
: True if option -a is set. Read-only variable. $-d
: The alias of $DEBUG. See $DEBUG above for further discussion. $-F
: The alias to $;. $-i
: In in-place-edit mode, this variable holds the extension, otherwise
  nil. $-I
: The alias to $:. $-l
: True if option -l is set. Read-only variable. $-p
: True if option -p is set. Read-only variable. $-v
: An alias of $VERBOSE. See $VERBOSE above for further discussion. $-w
: An alias of $VERBOSE. See $VERBOSE above for further discussion.

## Pre-defined global constants

TRUE
: The typical true value. FALSE
: The false itself. NIL
: The nil itself. STDIN
: The standard input. The default value for $stdin. STDOUT
: The standard output. The default value for $stdout. STDERR
: The standard error output. The default value for $stderr. ENV
: The hash contains current environment variables. ARGF
: The alias to the $<. ARGV
: The alias to the $\*. DATA
: The file object of the script, pointing just after **END**.
  RUBY\_VERSION
: The ruby version string (VERSION was deprecated). RUBY\_RELEASE\_DATE
: The release date string. RUBY\_PLATFORM
: The platform identifier.



## English

Include the English library file in a Ruby script, and you can reference
the global variables such as VAR\{$\_} using less cryptic names, listed
in the following table.% vref\{tab:english}.

Without 'English'\:


```ruby
$\ = ' -- '
"waterbuffalo" =~ /buff/
print $', $$, "\n"
```

With English:


```ruby
require "English"

$OUTPUT_FIELD_SEPARATOR = ' -- '
"waterbuffalo" =~ /buff/
print $POSTMATCH, $PID, "\n"
```

Below is a full list of descriptive aliases and their associated global
variable:

$ERROR\_INFO
: $! $ERROR\_POSITION
: $@ $FS
: $; $FIELD\_SEPARATOR
: $; $OFS
: $, $OUTPUT\_FIELD\_SEPARATOR
: $, $RS
: $/ $INPUT\_RECORD\_SEPARATOR
: $/ $ORS
: $\\ $OUTPUT\_RECORD\_SEPARATOR
: $\\ $INPUT\_LINE\_NUMBER
: $. $NR
: $. $LAST\_READ\_LINE
: $\_ $DEFAULT\_OUTPUT
: $> $DEFAULT\_INPUT
: $< $PID
: \$$ $PROCESS\_ID
: \$$ $CHILD\_STATUS
: $? $LAST\_MATCH\_INFO
: $~ $IGNORECASE
: $= $ARGV
: $\* $MATCH
: $& $PREMATCH
: $\` $POSTMATCH
: $' $LAST\_PAREN\_MATCH
: $+

