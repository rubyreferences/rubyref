# Alternative debugging/breakpoint solutions

Since Ruby 2.5.0, there is [Binding#irb](#TODO) method, allowing to enter [IRB](#TODO) session at the point of call.

Third-party libraries:

* [byebug](https://github.com/deivid-rodriguez/byebug) is currently most used and freature-rich Ruby debugger;
* [pry](https://github.com/pry/pry) interactive console (alternative to IRB) also provides [Binding#pry] method.