---
title: net/imap
prev: "/stdlib/networking-web/net/http.html"
next: "/stdlib/networking-web/net/pop.html"
---


```ruby
require 'net/imap'
```

## Net::IMAP

Net::IMAP implements Internet Message Access Protocol (IMAP) client
functionality. The protocol is described in \[IMAP\].

### IMAP Overview

An IMAP client connects to a server, and then authenticates itself using
either `#authenticate`() or `#login`(). Having authenticated itself,
there is a range of commands available to it. Most work with mailboxes,
which may be arranged in an hierarchical namespace, and each of which
contains zero or more messages. How this is implemented on the server is
implementation-dependent; on a UNIX server, it will frequently be
implemented as files in mailbox format within a hierarchy of
directories.

To work on the messages within a mailbox, the client must first select
that mailbox, using either `#select`() or (for read-only access)
`#examine`(). Once the client has successfully selected a mailbox, they
enter *selected* state, and that mailbox becomes the *current* mailbox,
on which mail-item related commands implicitly operate.

Messages have two sorts of identifiers: message sequence numbers and
UIDs.

Message sequence numbers number messages within a mailbox from 1 up to
the number of items in the mailbox. If a new message arrives during a
session, it receives a sequence number equal to the new size of the
mailbox. If messages are expunged from the mailbox, remaining messages
have their sequence numbers "shuffled down" to fill the gaps.

UIDs, on the other hand, are permanently guaranteed not to identify
another message within the same mailbox, even if the existing message is
deleted. UIDs are required to be assigned in ascending (but not
necessarily sequential) order within a mailbox; this means that if a
non-IMAP client rearranges the order of mailitems within a mailbox, the
UIDs have to be reassigned. An IMAP client thus cannot rearrange message
orders.

### Examples of Usage

#### List sender and subject of all recent messages in the default mailbox


```ruby
imap = Net::IMAP.new('mail.example.com')
imap.authenticate('LOGIN', 'joe_user', 'joes_password')
imap.examine('INBOX')
imap.search(["RECENT"]).each do |message_id|
  envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
  puts "#{envelope.from[0].name}: \t#{envelope.subject}"
end
```

#### Move all messages from April 2003 from "Mail/sent-mail" to "Mail/sent-apr03"


```ruby
imap = Net::IMAP.new('mail.example.com')
imap.authenticate('LOGIN', 'joe_user', 'joes_password')
imap.select('Mail/sent-mail')
if not imap.list('Mail/', 'sent-apr03')
  imap.create('Mail/sent-apr03')
end
imap.search(["BEFORE", "30-Apr-2003", "SINCE", "1-Apr-2003"]).each do |message_id|
  imap.copy(message_id, "Mail/sent-apr03")
  imap.store(message_id, "+FLAGS", [:Deleted])
end
imap.expunge
```

### Thread Safety

Net::IMAP supports concurrent threads. For example,


```ruby
imap = Net::IMAP.new("imap.foo.net", "imap2")
imap.authenticate("cram-md5", "bar", "password")
imap.select("inbox")
fetch_thread = Thread.start { imap.fetch(1..-1, "UID") }
search_result = imap.search(["BODY", "hello"])
fetch_result = fetch_thread.value
imap.disconnect
```

This script invokes the FETCH command and the SEARCH command
concurrently.

<a
href='https://ruby-doc.org/stdlib-2.5.0/libdoc/net/imap/rdoc/Net::IMAP.html'
class='ruby-doc remote' target='_blank'>Net::IMAP Reference</a>

