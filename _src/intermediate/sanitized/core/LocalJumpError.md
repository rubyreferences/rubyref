# LocalJumpError

Raised when Ruby can't yield as requested.

A typical scenario is attempting to yield when no block is given:

    def call_block
      yield 42
    end
    call_block

*raises the exception:*

    LocalJumpError: no block given (yield)

A more subtle example:

    def get_me_a_return
      Proc.new { return 42 }
    end
    get_me_a_return.call

*raises the exception:*

    LocalJumpError: unexpected return

[LocalJumpError Reference](https://ruby-doc.org/core-2.6/LocalJumpError.html)