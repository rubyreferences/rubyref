# Enumerable

The Enumerable mixin provides collection classes with several traversal and
searching methods, and with the ability to sort. The class must provide a
method `#each`, which yields successive members of the collection. If
`Enumerable#max`, `#min`, or `#sort` is used, the objects in the collection must
also implement a meaningful `<=>` operator, as these methods rely on an
ordering between members of the collection.

[Enumerable Reference](https://ruby-doc.org/core-2.7.0/Enumerable.html)