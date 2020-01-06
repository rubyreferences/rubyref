---
title: Warning
prev: "/builtin/exception/exception-classes.html"
next: "/builtin/system-cli.html"
---

## Warning[](#warning)

<div class="since-version">Since Ruby 2.4</div>

The Warning module contains a single method named `#warn`, and the module extends itself, making Warning.warn available. Warning.warn is called for all warnings issued by Ruby. By default, warnings are printed to $stderr.

By overriding Warning.warn, you can change how warnings are handled by Ruby, either filtering some warnings, and/or outputting warnings somewhere other than $stderr. When Warning.warn is overridden, super can be called to get the default behavior of printing the warning to $stderr.

<a href='https://ruby-doc.org/core-2.7.0/Warning.html' class='ruby-doc remote' target='_blank'>Warning Reference</a>

