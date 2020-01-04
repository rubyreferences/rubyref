---
title: 'bundler: Managing dependencies'
prev: stdlib/development/benchmark.html
next: stdlib/development/coverage.html
---

## Bundler[](#bundler)

Bundler provides a consistent environment for Ruby projects by tracking
and installing the exact gems and versions that are needed.

Since Ruby 2.6, Bundler is a part of Ruby's standard library.

Bunder is used by creating *gemfiles* listing all the project
dependencies and (optionally) their versions and then using


```ruby
require 'bundler/setup'
```

or Bundler.setup to setup environment where only specified gems and
their specified versions could be used.

See <a href='https://bundler.io/docs.html' class='remote'
target='_blank'>Bundler website</a> for extensive documentation on
gemfiles creation and Bundler usage.

As a standard library inside project, Bundler could be used for
introspection of loaded and required modules.

<a
href='https://ruby-doc.org/stdlib-2.7.0/libdoc/bundler/rdoc/Bundler.html'
class='ruby-doc remote' target='_blank'>Bundler Reference</a>









