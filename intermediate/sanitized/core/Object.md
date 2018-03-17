# Object

Object is the default root of all Ruby objects.  Object inherits from
BasicObject which allows creating alternate object hierarchies.  Methods on
Object are available to all classes unless explicitly overridden.

Object mixes in the Kernel module, making the built-in kernel functions
globally accessible.  Although the instance methods of Object are defined by
the Kernel module, we have chosen to document them here for clarity.

When referencing constants in classes inheriting from Object you do not need
to use the full namespace.  For example, referencing `File` inside `YourClass`
will find the top-level File class.

In the descriptions of Object's methods, the parameter *symbol* refers to a
symbol, which is either a quoted string or a Symbol (such as `:name`).