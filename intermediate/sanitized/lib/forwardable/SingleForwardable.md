# SingleForwardable

SingleForwardable can be used to setup delegation at the object level as well.

    printer = String.new
    printer.extend SingleForwardable        # prepare object for delegation
    printer.def_delegator "STDOUT", "puts"  # add delegation for STDOUT.puts()
    printer.puts "Howdy!"

Also, SingleForwardable can be used to set up delegation for a Class or
Module.

    class Implementation
      def self.service
        puts "serviced!"
      end
    end

    module Facade
      extend SingleForwardable
      def_delegator :Implementation, :service
    end

    Facade.service #=> serviced!

If you want to use both Forwardable and SingleForwardable, you can use methods
def_instance_delegator and def_single_delegator, etc.