# Code Comments

Ruby has two types of comments: inline and block.

Inline comments start with the `#` character and continue until the end of the
line:

    # On a separate line
    class Foo # or at the end of the line
      # can be indented
      def bar
      end
    end

Block comments start with `=begin` and end with `=end`. Each should start on a
separate line.

    =begin
    This is
    commented out
    =end

    class Foo
    end

    =begin some_tag
    this works, too
    =end

`=begin` and `=end` can not be indented, so this is a syntax error:

    class Foo
      =begin
      Will not work
      =end
    end

