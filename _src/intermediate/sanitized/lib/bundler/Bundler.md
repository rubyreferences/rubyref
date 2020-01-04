# Bundler

Bundler provides a consistent environment for Ruby projects by tracking and
installing the exact gems and versions that are needed.

Since Ruby 2.6, Bundler is a part of Ruby's standard library.

Bunder is used by creating *gemfiles* listing all the project dependencies and
(optionally) their versions and then using

    require 'bundler/setup'

or Bundler.setup to setup environment where only specified gems and their
specified versions could be used.

See [Bundler website](https://bundler.io/docs.html) for extensive
documentation on gemfiles creation and Bundler usage.

As a standard library inside project, Bundler could be used for introspection
of loaded and required modules.

[Bundler Reference](https://ruby-doc.org/stdlib-2.7.0/libdoc/bundler/rdoc/Bundler.html)