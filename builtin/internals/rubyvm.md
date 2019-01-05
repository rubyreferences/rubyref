---
title: RubyVM
prev: "/builtin/internals.html"
next: "/builtin/marshal.html"
---

## RubyVM[](#rubyvm)

The RubyVM module provides some access to Ruby internals. This module is
for very limited purposes, such as debugging, prototyping, and research.
Normal users must not use it.

<a href='https://ruby-doc.org/core-2.6/RubyVM.html' class='ruby-doc
remote' target='_blank'>RubyVM Reference</a>



### RubyVM::AbstractSyntaxTree[](#rubyvmabstractsyntaxtree)

<div class="since-version">Since Ruby 2.6</div>

AbstractSyntaxTree provides methods to parse Ruby code into abstract
syntax trees. The nodes in the tree are instances of
RubyVM::AbstractSyntaxTree::Node.

<a href='https://ruby-doc.org/core-2.6/RubyVM/AbstractSyntaxTree.html'
class='ruby-doc remote' target='_blank'>RubyVM::AbstractSyntaxTree
Reference</a>



### RubyVM::InstructionSequence[](#rubyvminstructionsequence)

The InstructionSequence class represents a compiled sequence of
instructions for the Ruby Virtual Machine.

With it, you can get a handle to the instructions that make up a method
or a proc, compile strings of Ruby code down to VM instructions, and
disassemble instruction sequences to strings for easy inspection. It is
mostly useful if you want to learn how the Ruby VM works, but it also
lets you control various settings for the Ruby iseq compiler.

You can find the source for the VM instructions in `insns.def` in the
Ruby source.

The instruction sequence results will almost certainly change as Ruby
changes, so example output in this documentation may be different from
what you see.

<a href='https://ruby-doc.org/core-2.6/RubyVM/InstructionSequence.html'
class='ruby-doc remote' target='_blank'>RubyVM::InstructionSequence
Reference</a>



### RubyVM::MJIT[](#rubyvmmjit)

RubyVM::MJIT

<a href='https://ruby-doc.org/core-2.6/RubyVM/MJIT.html' class='ruby-doc
remote' target='_blank'>RubyVM::MJIT Reference</a>

