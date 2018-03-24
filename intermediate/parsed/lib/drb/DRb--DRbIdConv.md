# DRb::DRbIdConv

Class responsible for converting between an object and its id.

This, the default implementation, uses an object's local ObjectSpace __id__ as
its id.  This means that an object's identification over drb remains valid
only while that object instance remains alive within the server runtime.

For alternative mechanisms, see DRb::TimerIdConv in rdb/timeridconv.rb and
DRbNameIdConv in sample/name.rb in the full drb distribution.

[DRb::DRbIdConv Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/drb/rdoc/DRb::DRbIdConv.html)
