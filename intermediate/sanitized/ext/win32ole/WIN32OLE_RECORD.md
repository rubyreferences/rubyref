# WIN32OLE_RECORD

`WIN32OLE_RECORD` objects represents VT_RECORD OLE variant. Win32OLE returns
WIN32OLE_RECORD object if the result value of invoking OLE methods.

If COM server in VB.NET ComServer project is the following:

    Imports System.Runtime.InteropServices
    Public Class ComClass
        Public Structure Book
            <MarshalAs(UnmanagedType.BStr)> _
            Public title As String
            Public cost As Integer
        End Structure
        Public Function getBook() As Book
            Dim book As New Book
            book.title = "The Ruby Book"
            book.cost = 20
            Return book
        End Function
    End Class

then, you can retrieve getBook return value from the following Ruby script:

    require 'win32ole'
    obj = WIN32OLE.new('ComServer.ComClass')
    book = obj.getBook
    book.class # => WIN32OLE_RECORD
    book.title # => "The Ruby Book"
    book.cost  # => 20

[WIN32OLE_RECORD Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/win32ole/rdoc/WIN32OLE_RECORD.html)