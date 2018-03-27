
```ruby
require 'net/ftp'
```

# Net::FTP

This class implements the File Transfer Protocol. If you have used a
command-line FTP program, and are familiar with the commands, you will
be able to use this class easily. Some extra features are included to
take advantage of Ruby's style and strengths.

## Example


```ruby
require 'net/ftp'
```

### Example 1


```ruby
ftp = Net::FTP.new('example.com')
ftp.login
files = ftp.chdir('pub/lang/ruby/contrib')
files = ftp.list('n*')
ftp.getbinaryfile('nif.rb-0.91.gz', 'nif.gz', 1024)
ftp.close
```

### Example 2


```ruby
Net::FTP.open('example.com') do |ftp|
  ftp.login
  files = ftp.chdir('pub/lang/ruby/contrib')
  files = ftp.list('n*')
  ftp.getbinaryfile('nif.rb-0.91.gz', 'nif.gz', 1024)
end
```

[Net::FTP
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/net/ftp/rdoc/Net::FTP.html)

