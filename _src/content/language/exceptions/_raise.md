# Exceptions

## Raising Exceptions

Exceptions are raised with the [`Kernel#raise`](ref:Kernel#raise) method. It has three forms:

    raise # RuntimeError with default message
    raise "Some message" # RuntimeError with custom message
    raise ErrorClass, "Some message" # Custom error with custom message

`ErrorClass` should be a subclass of [Exception](../builtin/exception.md).

See [`Kernel#raise`](ref:Kernel#raise) for more details on raising exceptions.
