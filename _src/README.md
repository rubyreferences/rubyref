# Ruby Reference Renderer

This folder contains sources for the Ruby reference, hosted at [rubyreferences.github.io](https://rubyreferences.github.io/rubyref).

The idea is that reference should be:

* **full**: cover all aspects of the language, core classes, and standard library;
* **continuous**: provide unambiguous reading order from the simplest concepts to advanced development techniques;
* **actual**: correspond to the latest version of Ruby;
* **accessible**: easy to find, navigate and read from any device.

This is achieved by creating the reference with 90% of content taken from _official_ docs from Ruby source code, then formatted as a book and supplying it with some "missing" chapters. Thus, the goals are achieved:

* full:
  * language constructs are mostly covered by [doc/\*.rdoc](https://github.com/ruby/ruby/tree/trunk/doc) in Ruby repo, core and stdlib classes are also documented in RDoc;
  * some missing topics (like comments syntax or exception raising) and advanced ones (like code linting and testing) are covered by content written for this reference, but this content is compact and easy to update.
* continuous:
  * core docs are structured in a logical manner and formatted in a modern GitBook-alike style, the way they can be read for _studying_ Ruby from basics to advanced topics;
* actual:
  * as most of the docs are taken from Ruby sources (and some from ruby-lang.org repository), the reference is relatively easy to update for the new version of Ruby;
* accessible:
  * static site with modern, mobile-ready design is easy to bookmark, read from mobile, and navigate in a continuous or random way.

## Source guide

* `exe/parse.rb` parses all `ruby/` repository sources (`doc/*.rdoc`, `*.c`, `lib/`, `ext/`) with RDoc, and extracts Markdown documentation into `intermediate/parsed/`;
  * it also renders `intermediate/parsed/_special/kernel.md` structured list of `Kernel` methods (structure is described in `config/kernel.yml`)
* `exe/sanitize.rb` is an ad-hoc script to cleanup Markdown output of RDoc and put it into `intermediate/sanitized/`
* `exe/render.rb` takes book structure from `config/structure.yml`, and renders it into `../_data/book.yml` (book structure for Jekyll) and a lot of `.md` files in `..`, which can be further rendered for Jekyll into a book;
  * it also uses the content written especially for this reference from `content/` folder, and imported from Ruby site in `ruby-lang.org` folder;
* `exe/list.rb` is utility script which compares list of extracted files in `intermediate/parsed` with list of files to render in `config/structure.yml` (it is easy to use it for the next versions to not forget newly emerged docs).

**For the next version of Ruby**, this things should be done:

* `ruby/` submodule should be switched to new branch;
* Ruby version should be updated in `config/ruby_version.txt`;
* new `parse`→`sanitize`→`render` cycle should be done (using `list` to not miss new docs);
* `content/stdlib/bundled.md` should be checked manually (if new bundled gems were added in a new version)
* `config/kernel.yml` should be checked manually (if new `Kernel` methods were added).

## Contributing

The repo gladly accepts contributions in the regular fork-change-PR flow.

The areas that require most care, as of now, are:

* content editing, in `content` folder (that was written specifically for this reference), I am Ukrainian :)
* content structuring review and discussion;
* review of content converted from RDoc, in search for broken formatting and updating scripts to make it cleaner (for example, Regexp chapter definitely have some minor problems).

## Credits and licenses

The components of the reference are:

* Docs parsed from Ruby and its libraries [source](https://github.com/ruby/ruby);
* [Ruby site](https://github.com/ruby/www.ruby-lang.org) pages;
* Book theme borrowed from [mdBook](https://github.com/rust-lang-nursery/mdBook) project.

Those components licenses should be found in corresponding projects.

The license for the work of this repository (rendering scripts, and content in `content/` folder) is **Public Domain**.