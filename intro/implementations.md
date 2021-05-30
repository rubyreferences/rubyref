---
title: Other Implementations of Ruby
prev: "/intro/installation.html"
next: "/intro/irb.html"
---

## Other Implementations of Ruby[](#other-implementations-of-ruby)

Ruby, as a language, has a few different implementations. This page has been discussing the reference implementation, in the community often referred to as **MRI** (“Matz’s Ruby Interpreter”) or **CRuby** (since it is written in C), but there are also others. They are often useful in certain situations, provide extra integration to other languages or environments, or have special features that MRI doesn’t.

Here’s a list:

* <a href='http://jruby.org' class='remote' target='_blank'>JRuby</a> is Ruby atop the JVM (Java Virtual Machine), utilizing the JVM’s optimizing JIT compilers, garbage collectors, concurrent threads, tool ecosystem, and vast collection of libraries.
* <a href='http://rubini.us' class='remote' target='_blank'>Rubinius</a> is ‘Ruby written in Ruby’. Built on top of LLVM, Rubinius sports a nifty virtual machine that other languages are being built on top of, too.
* <a href='https://github.com/oracle/truffleruby' class='remote' target='_blank'>TruffleRuby</a> is a high performance Ruby implementation on top of GraalVM.
* <a href='http://www.mruby.org/' class='remote' target='_blank'>mruby</a> is a lightweight implementation of the Ruby language that can be linked and embedded within an application. Its development is led by Ruby’s creator Yukihiro “Matz” Matsumoto.
* <a href='http://www.ironruby.net' class='remote' target='_blank'>IronRuby</a> is an implementation “tightly integrated with the .NET Framework”.
* <a href='http://maglev.github.io' class='remote' target='_blank'>MagLev</a> is “a fast, stable, Ruby implementation with integrated object persistence and distributed shared cache”.
* <a href='https://github.com/parrot/cardinal' class='remote' target='_blank'>Cardinal</a> is a “Ruby compiler for <a href='http://parrot.org' class='remote' target='_blank'>Parrot</a> Virtual Machine” (Perl 6).

For a more complete list, see <a href='https://github.com/planetruby/awesome-rubies' class='remote' target='_blank'>Awesome Rubies</a>.



> See "Installers" and "Managers" sections of the [previous chapter](installation.md) about downloading and installing different versions and implementations of Ruby.

