# ObjectSpace

The ObjectSpace module contains a number of routines that interact with the
garbage collection facility and allow you to traverse all living objects with
an iterator.

ObjectSpace also provides support for object finalizers, procs that will be
called when a specific object is about to be destroyed by garbage collection.

    require 'objspace'

    a = "A"
    b = "B"

    ObjectSpace.define_finalizer(a, proc {|id| puts "Finalizer one on #{id}" })
    ObjectSpace.define_finalizer(b, proc {|id| puts "Finalizer two on #{id}" })

*produces:*

    Finalizer two on 537763470
    Finalizer one on 537763480

[ObjectSpace Reference](http://ruby-doc.org/core-2.5.0/ObjectSpace.html)
