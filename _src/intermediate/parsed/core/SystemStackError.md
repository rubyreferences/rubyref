# SystemStackError

Raised in case of a stack overflow.

    def me_myself_and_i
      me_myself_and_i
    end
    me_myself_and_i

*raises the exception:*

    SystemStackError: stack level too deep

[SystemStackError Reference](https://ruby-doc.org/core-2.6/SystemStackError.html)
