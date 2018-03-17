# Warning

The Warning module contains a single method named #warn, and the module
extends itself, making `Warning.warn` available. Warning.warn is called for
all warnings issued by Ruby. By default, warnings are printed to $stderr.

By overriding Warning.warn, you can change how warnings are handled by Ruby,
either filtering some warnings, and/or outputting warnings somewhere other
than $stderr.  When Warning.warn is overridden, super can be called to get the
default behavior of printing the warning to $stderr.
