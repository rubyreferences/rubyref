---
title: net/pop
prev: "/stdlib/networking-web/net/imap.html"
next: "/stdlib/networking-web/net/smtp.html"
---


```ruby
require 'net/pop'
```

# Net::POP3

This library provides functionality for retrieving email via POP3, the
Post Office Protocol version 3. For details of POP3, see
[RFC1939](http://www.ietf.org/rfc/rfc1939.txt).

## Examples

### Retrieving Messages

This example retrieves messages from the server and deletes them on the
server.

Messages are written to files named 'inbox/1', 'inbox/2', .... Replace
'pop.example.com' with your POP3 server address, and 'YourAccount' and
'YourPassword' with the appropriate account details.


```ruby
require 'net/pop'

pop = Net::POP3.new('pop.example.com')
pop.start('YourAccount', 'YourPassword')             # (1)
if pop.mails.empty?
  puts 'No mail.'
else
  i = 0
  pop.each_mail do |m|   # or "pop.mails.each ..."   # (2)
    File.open("inbox/#{i}", 'w') do |f|
      f.write m.pop
    end
    m.delete
    i += 1
  end
  puts "#{pop.mails.size} mails popped."
end
pop.finish                                           # (3)
```

1.  Call Net::POP3#start and start POP session.
2.  Access messages by using POP3#each\_mail and/or POP3#mails.
3.  Close POP session by calling POP3#finish or use the block form of
    `#start`.

### Shortened Code

The example above is very verbose. You can shorten the code by using
some utility methods. First, the block form of Net::POP3.start can be
used instead of POP3.new, POP3#start and POP3#finish.


```ruby
require 'net/pop'

Net::POP3.start('pop.example.com', 110,
                'YourAccount', 'YourPassword') do |pop|
  if pop.mails.empty?
    puts 'No mail.'
  else
    i = 0
    pop.each_mail do |m|   # or "pop.mails.each ..."
      File.open("inbox/#{i}", 'w') do |f|
        f.write m.pop
      end
      m.delete
      i += 1
    end
    puts "#{pop.mails.size} mails popped."
  end
end
```

POP3#delete\_all is an alternative for `#each_mail` and `#delete`.


```ruby
require 'net/pop'

Net::POP3.start('pop.example.com', 110,
                'YourAccount', 'YourPassword') do |pop|
  if pop.mails.empty?
    puts 'No mail.'
  else
    i = 1
    pop.delete_all do |m|
      File.open("inbox/#{i}", 'w') do |f|
        f.write m.pop
      end
      i += 1
    end
  end
end
```

And here is an even shorter example.


```ruby
require 'net/pop'

i = 0
Net::POP3.delete_all('pop.example.com', 110,
                     'YourAccount', 'YourPassword') do |m|
  File.open("inbox/#{i}", 'w') do |f|
    f.write m.pop
  end
  i += 1
end
```

### Memory Space Issues

All the examples above get each message as one big string. This example
avoids this.


```ruby
require 'net/pop'

i = 1
Net::POP3.delete_all('pop.example.com', 110,
                     'YourAccount', 'YourPassword') do |m|
  File.open("inbox/#{i}", 'w') do |f|
    m.pop do |chunk|    # get a message little by little.
      f.write chunk
    end
    i += 1
  end
end
```

### Using APOP

The net/pop library supports APOP authentication. To use APOP, use the
Net::APOP class instead of the Net::POP3 class. You can use the utility
method, Net::POP3.APOP(). For example:


```ruby
require 'net/pop'

# Use APOP authentication if $isapop == true
pop = Net::POP3.APOP($isapop).new('apop.example.com', 110)
pop.start('YourAccount', 'YourPassword') do |pop|
  # Rest of the code is the same.
end
```

### Fetch Only Selected Mail Using 'UIDL' POP Command

If your POP server provides UIDL functionality, you can grab only
selected mails from the POP server. e.g.


```ruby
def need_pop?( id )
  # determine if we need pop this mail...
end

Net::POP3.start('pop.example.com', 110,
                'Your account', 'Your password') do |pop|
  pop.mails.select { |m| need_pop?(m.unique_id) }.each do |m|
    do_something(m.pop)
  end
end
```

The `POPMail#unique_id`() method returns the unique-id of the message as
a String. Normally the unique-id is a hash of the message.

[Net::POP3
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/net/pop/rdoc/Net::POP3.html)



[Net::APOP
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/net/pop/rdoc/Net::APOP.html)

