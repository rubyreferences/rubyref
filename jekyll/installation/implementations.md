---
title: Other Implementations of Ruby
prev: "/installation.html"
next: "/irb.html"
---

# Other Implementations of Ruby

Ruby, as a language, has a few different implementations. This page has
been discussing the reference implementation, in the community often
referred to as **MRI** (“Matz’s Ruby Interpreter”) or **CRuby** (since
it is written in C), but there are also others. They are often useful in
certain situations, provide extra integration to other languages or
environments, or have special features that MRI doesn’t.

Here’s a list:

* [JRuby](http://jruby.org) is Ruby atop the JVM (Java Virtual Machine),
  utilizing the JVM’s optimizing JIT compilers, garbage collectors,
  concurrent threads, tool ecosystem, and vast collection of libraries.
* [Rubinius](http://rubini.us) is ‘Ruby written in Ruby’. Built on top
  of LLVM, Rubinius sports a nifty virtual machine that other languages
  are being built on top of, too.
* [MacRuby](http://www.macruby.org) is a Ruby that’s tightly integrated
  with Apple’s Cocoa libraries for Mac OS X, allowing you to write
  desktop applications with ease.
* [mruby](http://www.mruby.org/) is a lightweight implementation of the
  Ruby language that can be linked and embedded within an application.
  Its development is led by Ruby’s creator Yukihiro “Matz” Matsumoto.
* [IronRuby](http://www.ironruby.net) is an implementation “tightly
  integrated with the .NET Framework”.
* [MagLev](http://ruby.gemstone.com) is “a fast, stable, Ruby
  implementation with integrated object persistence and distributed
  shared cache”.
* [Cardinal](https://github.com/parrot/cardinal) is a “Ruby compiler for
  [Parrot](http://parrot.org) Virtual Machine” (Perl 6).



> See [previous chapter](../installation.md) about downloading and
> installing different versions and implementations of Ruby.

