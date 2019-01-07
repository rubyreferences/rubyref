# WIN32OLE_VARIANT

`WIN32OLE_VARIANT` objects represents OLE variant.

Win32OLE converts Ruby object into OLE variant automatically when invoking OLE
methods. If OLE method requires the argument which is different from the
variant by automatic conversion of Win32OLE, you can convert the specfied
variant type by using WIN32OLE_VARIANT class.

    param = WIN32OLE_VARIANT.new(10, WIN32OLE::VARIANT::VT_R4)
    oleobj.method(param)

WIN32OLE_VARIANT does not support VT_RECORD variant. Use WIN32OLE_RECORD class
instead of WIN32OLE_VARIANT if the VT_RECORD variant is needed.

[WIN32OLE_VARIANT Reference](https://ruby-doc.org/stdlib-2.6/libdoc/win32ole/rdoc/WIN32OLE_VARIANT.html)
