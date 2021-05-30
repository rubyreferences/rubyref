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

The main configuration of what and how to render is in `config/structure.yml`. Format should be (kinda) self-explanatory.

`Rakefile` does all the hard rendering work based on this config. Basically, the process is following:

1. Index RDoc from Ruby's `*.c` and `*.rb` files from `ruby/` repository into simple YAML lists of docs stored in `intermediate/rdoc/` (this is just "caching" step to not re-parse all source files on each small renderer change) -- `rake dev:parse_rdoc`
2. Convert this RDoc, and Ruby's documentation from `ruby/doc/**/*.rdoc` into Markdown, stored in `intermediate/parsed/` -- `rake dev:rdoc2md`
3. "Sanitize" (cleanup) all Markdown converted from RDoc, and Markdown sources from `ruby-lang.org/` submodule into `intermediate/sanitized/` -- `rake dev:sanitize_md`
  * it also renders `intermediate/sanitized/_special/kernel.md` structured list of `Kernel` methods (structure is described in `config/kernel.yml`)
4. Render final chapters (`*.md` files in `..` relative to folder where this README is) and TOC in `../_data/book.yml` -- `rake chapters` and `rake toc`, or just `rake` (default task)
  * Source(s) for each chapter are specified in `structure.yml`, and could be: a) sourced from Ruby's RDoc, b) sourced from ruby-lang.org site and c) written specifically for this reference (see `content/` folder)

Notes:
* all the intermediate file relationships are properly specified as Rake dependencies, so just `rake` will render/update all necessary intermediate steps (e.g., after updating Ruby sources, _everything_ will be rerendered accordingly with just one `rake` command); intermediate commands are available for development purposes (to debug some rendering peculiarities), for the same purposes intermediate files are Git-tracked
* `rake dev:validate` (which just runs all the rest of `dev:validate_*` tasks) allows to check if everything is specified and rendered properly.


**For the next version of Ruby**, this things should be done:

* `ruby/` submodule should be switched to new branch (and probably `ruby-lang.org/`, too);
* Ruby version should be updated in `config/ruby_version.txt`;
* then, just run `rake` (and use `rake validate` to check if everything is in place);
* `content/stdlib/bundled.md` should be checked manually (if new bundled gems were added in a new version)
* `config/kernel.yml` should be checked manually (if new `Kernel` methods were added);
* manual review of everything is **necessary**, to check if new version's docs are rendered properly, and if `structure.yml` not omits something that is new for this version.

## Contributing

The repo gladly accepts contributions in the regular fork-change-PR flow.

The areas that require most care, as of now, are:

* content editing, in `content` folder (that was written specifically for this reference), I am Ukrainian :)
* content structuring review and discussion;
* review of content converted from RDoc, in search for broken formatting and updating scripts to make it cleaner.

## Credits and licenses

The components of the reference are:

* Docs parsed from Ruby and its libraries [source](https://github.com/ruby/ruby);
* [Ruby site](https://github.com/ruby/www.ruby-lang.org) pages;
* Book theme borrowed from [mdBook](https://github.com/rust-lang-nursery/mdBook) project.

Those components licenses should be found in corresponding projects.

The license for the work of this repository (rendering scripts, and content in `content/` folder) is **Public Domain**.