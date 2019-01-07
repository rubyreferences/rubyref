# RubyReference changelog

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
  * New links in Appendix A
* Lot of small content fixes and cleanups, including `Since Ruby (version)` badges besides some of functionality (incomplete, mostly catching what's new since 2.6, for reference to stay relevant and helpful for those who uses earlier versions)
* A bit of visual cleanup, including copyable links to sub-headers.