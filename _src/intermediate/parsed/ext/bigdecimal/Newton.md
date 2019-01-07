# Newton

newton.rb

Solves the nonlinear algebraic equation system f = 0 by Newton's method. This
program is not dependent on BigDecimal.

To call:
      n = nlsolve(f,x)
    where n is the number of iterations required,
          x is the initial value vector
          f is an Object which is used to compute the values of the equations to be solved.

It must provide the following methods:

f.values(x)
:   returns the values of all functions at x

f.zero
:   returns 0.0
f.one
:   returns 1.0
f.two
:   returns 2.0
f.ten
:   returns 10.0

f.eps
:   returns the convergence criterion (epsilon value) used to determine
    whether two values are considered equal. If |a-b| < epsilon, the two
    values are considered equal.


On exit, x is the solution vector.

[Newton Reference](https://ruby-doc.org/stdlib-2.6/libdoc/bigdecimal/rdoc/Newton.html)
