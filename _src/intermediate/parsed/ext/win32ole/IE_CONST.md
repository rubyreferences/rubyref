# IE_CONST

# begin
WIN32OLE.const_load(ie) WIN32OLE.constants.sort.each do |c|
    puts "#{c} = #{WIN32OLE.const_get(c)}"

end
# end

[IE_CONST Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/win32ole/rdoc/IE_CONST.html)
