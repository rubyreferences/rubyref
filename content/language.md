# Ruby Language Structure

This chapter describes all syntax constructs and general structure of Ruby programs.

As a brief overview, it can be said that:

* Ruby program consists of expressions dealing with [literals](language/literals.md), [variables](language/variables.md) and [constants](language/variables.md#constants).
* Expressions are:
  * [assignments](language/assignments.md);
  * [control expressions](language/control-expressions.md);
  * [method calls](language/methods-call.md);
  * definitions of modules, classes and methods.
* Ruby is object-oriented language, so the program is structured by defining [classes and modules](language/modules-classes.md) and their [methods](language/methods-def.md).
  * Ruby has open classes, for hygiene one can use [refinements](language/refinements.md).
* Error reporting and handling is done with [exceptions](language/exceptions.md).

Note that a lot of language constructs you will see in a typical Ruby program, are in fact, just _methods_. For example [`Kernel#raise`]() is used to raise an exception, and [`Module#private`]() is used to change method's visibility. This means that language core, described in this chapter, is pretty small, and everything else just follows usual rules for modules, methods and expressions.