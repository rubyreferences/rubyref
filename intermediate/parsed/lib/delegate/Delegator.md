# Delegator

This library provides three different ways to delegate method calls to an
object.  The easiest to use is SimpleDelegator.  Pass an object to the
constructor and all methods supported by the object will be delegated.  This
object can be changed later.

Going a step further, the top level DelegateClass method allows you to easily
setup delegation through class inheritance.  This is considerably more
flexible and thus probably the most common use for this library.

Finally, if you need full control over the delegation scheme, you can inherit
from the abstract class Delegator and customize as needed.  (If you find
yourself needing this control, have a look at Forwardable which is also in the
standard library.  It may suit your needs better.)

SimpleDelegator's implementation serves as a nice example of the use of
Delegator:

    class SimpleDelegator < Delegator
      def __getobj__
        @delegate_sd_obj # return object we are delegating to, required
      end

      def __setobj__(obj)
        @delegate_sd_obj = obj # change delegation object,
                               # a feature we're providing
      end
    end

## Notes

Be advised, RDoc will not detect delegated methods.
