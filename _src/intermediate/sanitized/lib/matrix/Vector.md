# Vector

The `Vector` class represents a mathematical vector, which is useful in its
own right, and also constitutes a row or column of a Matrix.

## Method Catalogue

To create a Vector:

*   Vector.[](*array)
*   Vector.elements(array, copy = true)
*   Vector.basis(size: n, index: k)
*   Vector.zero(n)


To access elements:

*   `#[]`(i)


To enumerate the elements:

*   `#each`2(v)
*   `#collect`2(v)


Properties of vectors:

*   `#angle_with`(v)
*   Vector.independent?(*vs)
*   `#independent?`(*vs)
*   `#zero?`


Vector arithmetic:

*   #*(x) "is matrix or number"
*   #+(v)
*   #-(v)
*   #/(v)
*   #+@
*   #-@


Vector functions:

*   `#inner_product`(v), dot(v)
*   `#cross_product`(v), cross(v)
*   `#collect`
*   `#magnitude`
*   `#map`
*   `#map`2(v)
*   `#norm`
*   `#normalize`
*   `#r`
*   `#round`
*   `#size`


Conversion to other data types:

*   `#covector`
*   `#to_a`
*   `#coerce`(other)


String representations:

*   `#to_s`
*   `#inspect`


[Vector Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/matrix/rdoc/Vector.html)