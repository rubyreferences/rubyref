# IE_CONST

WIN32OLE.const_load(ie) WIN32OLE.constants.sort.each do |c|
    puts "#{c} = #{WIN32OLE.const_get(c)}"

end

[IE_CONST Reference](https://ruby-doc.org/stdlib-2.6/libdoc/win32ole/rdoc/IE_CONST.html)