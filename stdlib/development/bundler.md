---
title: 'bundler: Managing dependencies'
prev: "/stdlib/development/benchmark.html"
next: "/stdlib/development/coverage.html"
---

## Bundler[](#bundler)

<div class="since-version">Since Ruby 2.6</div>

Bundler makes sure Ruby applications run the same code on every machine.

It does this by managing the gems that the application depends on. Given
a list of gems, it can automatically download and install those gems, as
well as any other gems needed by the gems that are listed. Before
installing gems, it checks the versions of every gem to make sure that
they are compatible, and can all be loaded at the same time. After the
gems have been installed, Bundler can help you update some or all of
them when new versions become available. Finally, it records the exact
versions that have been installed, so that others can install the exact
same gems.

An extensive documentation for Bundler, including guides, references and
best practices, could be found at <a href='https://bundler.io/'
class='remote' target='_blank'>its site</a>.

### Getting Started[](#getting-started)

Getting started with bundler is easy! Since Ruby 2.6, Bundler is a part
of Ruby's standard library.

Specify your dependencies in a Gemfile in your project's root:


```ruby
source 'https://rubygems.org'
gem 'nokogiri'
gem 'rack', '~> 2.0.1'
gem 'rspec'
```

Learn More: <a href='https://bundler.io/gemfile.html' class='remote'
target='_blank'>Gemfiles</a>.

Install all of the required gems from your specified sources:


```
$ bundle install
$ git add Gemfile Gemfile.lock
```

Learn More: <a href='https://bundler.io/bundle_install.html'
class='remote' target='_blank'>`bundle install`</a>.

The second command adds the Gemfile and Gemfile.lock to your repository.
This ensures that other developers on your app, as well as your
deployment environment, will all use the same third-party code that you
are using now.

Inside your app, load up the bundled environment:


```ruby
require 'rubygems'
require 'bundler/setup'

# require your gems as usual
require 'nokogiri'
```

Learn More: <a href='https://bundler.io/guides/bundler_setup.html'
class='remote' target='_blank'>`Bundler.setup`</a>.

