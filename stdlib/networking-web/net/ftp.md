---
title: net/ftp
prev: stdlib/networking-web/ipaddr.html
next: stdlib/networking-web/net/http.html
---


```ruby
require 'net/ftp'
```

## Net::FTP[](#netftp)

This class implements the File Transfer Protocol. If you have used a
command-line FTP program, and are familiar with the commands, you will
be able to use this class easily. Some extra features are included to
take advantage of Ruby's style and strengths.


```ruby
ftp = Net::FTP.new('example.com')
ftp.login
files = ftp.chdir('pub/lang/ruby/contrib')
files = ftp.list('n*')
ftp.getbinaryfile('nif.rb-0.91.gz', 'nif.gz', 1024)
ftp.close
```

Block form:


```ruby
Net::FTP.open('example.com') do |ftp|
  ftp.login
  files = ftp.chdir('pub/lang/ruby/contrib')
  files = ftp.list('n*')
  ftp.getbinaryfile('nif.rb-0.91.gz', 'nif.gz', 1024)
end
```

<a
href='https://ruby-doc.org/stdlib-2.7.0/libdoc/net/ftp/rdoc/Net/FTP.html'
class='ruby-doc remote' target='_blank'>Net::FTP Reference</a>

