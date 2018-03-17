# IE_CONST

WIN32OLE.const_load(ie) WIN32OLE.constants.sort.each do |c|
    puts "#{c} = #{WIN32OLE.const_get(c)}"

end
