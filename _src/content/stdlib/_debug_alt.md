# Alternative debugging/breakpoint solutions

Since Ruby 2.5.0, there is the [Binding#irb](ref:Binding#irb) method, which enters an [IRB](intro/irb.md) session at the point of call.

Third-party libraries:

* [byebug](https://github.com/deivid-rodriguez/byebug) is currently most used and freature-rich Ruby debugger;
* [pry](https://github.com/pry/pry) interactive console (alternative to IRB) also provides [#pry](http://www.rubydoc.info/github/pry/pry/master/Object#pry-instance_method) method.
