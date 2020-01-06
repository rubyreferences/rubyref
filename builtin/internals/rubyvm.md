---
title: RubyVM
prev: "/builtin/internals.html"
next: "/builtin/marshal.html"
---

## RubyVM[](#rubyvm)

The RubyVM module only exists on MRI. `RubyVM` is not defined in other Ruby implementations such as JRuby and TruffleRuby.

The RubyVM module provides some access to MRI internals. This module is for very limited purposes, such as debugging, prototyping, and research. Normal users must not use it. This module is not portable between Ruby implementations.

<a href='https://ruby-doc.org/core-2.7.0/RubyVM.html' class='ruby-doc remote' target='_blank'>RubyVM Reference</a>



### RubyVM::AbstractSyntaxTree[](#rubyvmabstractsyntaxtree)

<div class="since-version">Since Ruby 2.6</div>

AbstractSyntaxTree provides methods to parse Ruby code into abstract syntax trees. The nodes in the tree are instances of RubyVM::AbstractSyntaxTree::Node.

This class is MRI specific as it exposes implementation details of the MRI abstract syntax tree.

This class is experimental and its API is not stable, therefore it might change without notice. As examples, the order of children nodes is not guaranteed, the number of children nodes might change, there is no way to access children nodes by name, etc.

If you are looking for a stable API or an API working under multiple Ruby implementations, consider using the *parser* gem or Ripper. If you would like to make RubyVM::AbstractSyntaxTree stable, please join the discussion at https://bugs.ruby-lang.org/issues/14844.

<a href='https://ruby-doc.org/core-2.7.0/RubyVM/AbstractSyntaxTree.html' class='ruby-doc remote' target='_blank'>RubyVM::AbstractSyntaxTree Reference</a>



### RubyVM::InstructionSequence[](#rubyvminstructionsequence)

The InstructionSequence class represents a compiled sequence of instructions for the Virtual Machine used in MRI. Not all implementations of Ruby may implement this class, and for the implementations that implement it, the methods defined and behavior of the methods can change in any version.

With it, you can get a handle to the instructions that make up a method or a proc, compile strings of Ruby code down to VM instructions, and disassemble instruction sequences to strings for easy inspection. It is mostly useful if you want to learn how YARV works, but it also lets you control various settings for the Ruby iseq compiler.

You can find the source for the VM instructions in `insns.def` in the Ruby source.

The instruction sequence results will almost certainly change as Ruby changes, so example output in this documentation may be different from what you see.

Of course, this class is MRI specific.

<a href='https://ruby-doc.org/core-2.7.0/RubyVM/InstructionSequence.html' class='ruby-doc remote' target='_blank'>RubyVM::InstructionSequence Reference</a>



### RubyVM::MJIT[](#rubyvmmjit)

\::RubyVM::MJIT Provides access to the Method JIT compiler of MRI. Of course, this module is MRI specific.

<a href='https://ruby-doc.org/core-2.7.0/RubyVM/MJIT.html' class='ruby-doc remote' target='_blank'>RubyVM::MJIT Reference</a>

