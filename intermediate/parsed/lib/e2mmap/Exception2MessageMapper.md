# Exception2MessageMapper

Helper module for easily defining exceptions with predefined messages.

## Usage

1.
    class Foo
      extend Exception2MessageMapper
      def_e2message ExistingExceptionClass, "message..."
      def_exception :NewExceptionClass, "message..."[, superclass]
      ...
    end

2.
    module Error
      extend Exception2MessageMapper
      def_e2message ExistingExceptionClass, "message..."
      def_exception :NewExceptionClass, "message..."[, superclass]
      ...
    end
    class Foo
      include Error
      ...
    end

    foo = Foo.new
    foo.Fail ....

3.
    module Error
      extend Exception2MessageMapper
      def_e2message ExistingExceptionClass, "message..."
      def_exception :NewExceptionClass, "message..."[, superclass]
      ...
    end
    class Foo
      extend Exception2MessageMapper
      include Error
      ...
    end

    Foo.Fail NewExceptionClass, arg...
    Foo.Fail ExistingExceptionClass, arg...
