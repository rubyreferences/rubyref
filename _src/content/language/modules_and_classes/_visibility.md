There are three ways to define method's visibility, the first one being most used:

    # 1. Define visibility for several methods at once
    private

    def private_method1
      # ...
    end

    def private_method2
      # ...
    end

    public

    def public_again
      # ...
    end

    # 2. Postfactum definition
    def private_method1
      # ...
    end

    def private_method2
      # ...
    end

    private :private_method1, :private_method2

    # 3. Inline definition
    private def private_method1
      # ...
    end

    private def private_method2
      # ...
    end

The third one is in fact the same as the second (passing method name to `private`), just utilizing
the fact that `def` is an expression returning method name.

Note also that `public`, `private` and `protected` are not, in fact, keywords or some special syntax,
they are just regular methods of [Module](../builtin/core/module-class.md#module) class.