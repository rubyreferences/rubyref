# RubyVM::InstructionSequence

The InstructionSequence class represents a compiled sequence of instructions
for the Ruby Virtual Machine.

With it, you can get a handle to the instructions that make up a method or a
proc, compile strings of Ruby code down to VM instructions, and disassemble
instruction sequences to strings for easy inspection. It is mostly useful if
you want to learn how the Ruby VM works, but it also lets you control various
settings for the Ruby iseq compiler.

You can find the source for the VM instructions in `insns.def` in the Ruby
source.

The instruction sequence results will almost certainly change as Ruby changes,
so example output in this documentation may be different from what you see.

[RubyVM::InstructionSequence Reference](https://ruby-doc.org/core-2.6/RubyVM/InstructionSequence.html)
