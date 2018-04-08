It is possible to define a keyword argument with name that is not acceptable for a variable name,
like `class` or `next` (keywords). In this case, argument's value can be obtained via
[Binding](../builtin/core.md#binding).

    def html_tag(name, class:)
      # Will fail with SyntaxError
      # puts class

      # Works
      puts binding.local_variable_get('class')
    end
