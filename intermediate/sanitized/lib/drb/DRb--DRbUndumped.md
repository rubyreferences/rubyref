# DRb::DRbUndumped

Mixin module making an object undumpable or unmarshallable.

If an object which includes this module is returned by method called over drb,
then the object remains in the server space and a reference to the object is
returned, rather than the object being marshalled and moved into the client
space.

[DRb::DRbUndumped Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/drb/rdoc/DRb::DRbUndumped.html)