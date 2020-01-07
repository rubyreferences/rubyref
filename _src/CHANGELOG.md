# RubyReference changelog

## 2020-01-07 -- Ruby 2.7 update

* The whole site is re-rendered from [ruby_2_7](https://github.com/ruby/ruby/tree/ruby_2_7) branch of Ruby repo. Notable changes:
  * Pattern matching docs are added (in the absence of official docs, just a copy-paste of [my own PR](https://github.com/ruby/ruby/pull/2786) to Ruby itself)
  * Removed docs for stdlib parts that were dropped: scanf, shell, profiler
* Minor logical restructuring (bundler moved under Developing/Libraries, Fiber under Concurrency, etc.)
* Rendering and validation scripts are finally rewritten into proper `Rakefile` from a bunch of ad-hoc `*.rb` executables;
* A lot of small rendering bugs are fixed in the process.

## 2019-01-07 -- Ruby 2.6 update

* The whole site is re-rendered from [ruby_2_6](https://github.com/ruby/ruby/tree/ruby_2_6) branch of Ruby repo. Notable additions that made it into the reference rendering:
  * `RubyVM::AbstractSyntaxTree`;
  * `Enumerator::ArithmeticSequence`, `Enumerator::Chain`;
  * Endless ranges, timezones for `Time`
* Other additions:
  * "Ruby in 20 minutes" from the site
  * `RubyVM` (was not rendered for 2.5 because was not documented in Ruby repo)
  * `Enumerator::Lazy` (still has no documentation in Ruby repo, custom content written)
  * `File::Stat` and `File::Constants` (were missing in prev. version of reference due to bug)
  * `Bundler` in a standard library (custom content)
  * New links in Appendix B
* Lot of small content fixes and cleanups, including `Since Ruby (version)` badges besides some of functionality (incomplete, mostly catching what's new since 2.6, for reference to stay relevant and helpful for those who uses earlier versions)
* A bit of visual cleanup, including copyable links to sub-headers.
* Patreon link :)