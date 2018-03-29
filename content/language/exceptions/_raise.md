# Exceptions

## Raising Exceptions

Exceptions are raised with [`Kernel#raise`]() method. It has three forms:

    raise # RuntimeError with default message
    raise "Some message" # RuntimeError with custom message
    raise ErrorClass, "Some message" # Custom error with custom message

`ErrorClass` should be a subclass of [Exception](../builtin/errors-warnings.md).

See [`Kernel#raise`]() documentation for more details on raising exceptions.