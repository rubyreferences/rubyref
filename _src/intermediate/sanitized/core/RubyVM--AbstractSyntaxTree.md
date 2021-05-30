# RubyVM::AbstractSyntaxTree

AbstractSyntaxTree provides methods to parse Ruby code into abstract syntax
trees. The nodes in the tree are instances of
RubyVM::AbstractSyntaxTree::Node.

This class is MRI specific as it exposes implementation details of the MRI
abstract syntax tree.

This class is experimental and its API is not stable, therefore it might
change without notice. As examples, the order of children nodes is not
guaranteed, the number of children nodes might change, there is no way to
access children nodes by name, etc.

If you are looking for a stable API or an API working under multiple Ruby
implementations, consider using the *parser* gem or Ripper. If you would like
to make RubyVM::AbstractSyntaxTree stable, please join the discussion at
https://bugs.ruby-lang.org/issues/14844.

[RubyVM::AbstractSyntaxTree Reference](https://ruby-doc.org/core-2.7.0/RubyVM/AbstractSyntaxTree.html)