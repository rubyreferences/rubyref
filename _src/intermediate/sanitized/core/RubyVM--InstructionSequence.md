# RubyVM::InstructionSequence

The InstructionSequence class represents a compiled sequence of instructions
for the Virtual Machine used in MRI. Not all implementations of Ruby may
implement this class, and for the implementations that implement it, the
methods defined and behavior of the methods can change in any version.

With it, you can get a handle to the instructions that make up a method or a
proc, compile strings of Ruby code down to VM instructions, and disassemble
instruction sequences to strings for easy inspection. It is mostly useful if
you want to learn how YARV works, but it also lets you control various
settings for the Ruby iseq compiler.

You can find the source for the VM instructions in `insns.def` in the Ruby
source.

The instruction sequence results will almost certainly change as Ruby changes,
so example output in this documentation may be different from what you see.

Of course, this class is MRI specific.

[RubyVM::InstructionSequence Reference](https://ruby-doc.org/core-2.7.0/RubyVM/InstructionSequence.html)