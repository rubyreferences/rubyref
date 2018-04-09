# Constants

Constants are defined by assigning a value to any identifier starting with an **upper-case letter**:

    X = 1
    NAMES = %w[Bob Jane Jim]

Class and module definitions (see [Modules and Classes](./modules-classes.md)) also define constants,
assigned to the class/module name:

    class A
      # ...
    end
    # Roughly equivalent to:
    A = Class.new do
      # ...
    end

See also: [Constants scoping](./modules-classes.md#constants) section in "Modules and Classes" chapter.
