# Ruby Language Structure

This chapter describes the syntax constructs and general structure of Ruby programs.

As a brief overview, it can be said that:

* Ruby program consists of expressions dealing with [literals](language/literals.md), [variables](language/variables-constants.md) and [constants](language/variables-constants.md#constants).
* Expressions are:
  * [assignments](language/assignment.md);
  * [control expressions](language/control-expressions.md);
  * [method calls](language/methods-call.md);
  * definitions of modules, classes and methods.
* Ruby is an object-oriented language, so the program is structured by defining [classes and modules](language/modules-classes.md) and their [methods](language/methods-def.md).
  * Ruby has open classes that can be changed any time (even the core ones, like `String`). To localize class changes and implement hygienic extensions, one can use [refinements](language/refinements.md).
* Error reporting and handling is done with [exceptions](language/exceptions.md).

Note that many of the language constructs you will see in a typical Ruby program, are in fact, just _methods_. For example [`Kernel#raise`](ref:Kernel#raise) is used to raise an exception, and [`Module#private`](ref:Module#private) is used to change a method's visibility. As a result, the language core described in this chapter is pretty small, and everything else just follows usual rules for modules, methods and expressions.
