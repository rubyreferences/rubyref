# Net::SMTP

## What is This Library?

This library provides functionality to send internet mail via SMTP, the Simple
Mail Transfer Protocol. For details of SMTP itself, see [RFC2821]
(http://www.ietf.org/rfc/rfc2821.txt).

## What is This Library NOT?

This library does NOT provide functions to compose internet mails. You must
create them by yourself. If you want better mail support, try RubyMail or
TMail or search for alternatives in [RubyGems.org](https://rubygems.org/) or
[The Ruby Toolbox](https://www.ruby-toolbox.com/).

FYI: the official documentation on internet mail is: [RFC2822]
(http://www.ietf.org/rfc/rfc2822.txt).

## Examples

### Sending Messages

You must open a connection to an SMTP server before sending messages. The
first argument is the address of your SMTP server, and the second argument is
the port number. Using SMTP.start with a block is the simplest way to do this.
This way, the SMTP connection is closed automatically after the block is
executed.

    require 'net/smtp'
    Net::SMTP.start('your.smtp.server', 25) do |smtp|
      # Use the SMTP object smtp only in this block.
    end

Replace 'your.smtp.server' with your SMTP server. Normally your system manager
or internet provider supplies a server for you.

Then you can send messages.

    msgstr = <<END_OF_MESSAGE
    From: Your Name <your@mail.address>
    To: Destination Address <someone@example.com>
    Subject: test message
    Date: Sat, 23 Jun 2001 16:26:43 +0900
    Message-Id: <unique.message.id.string@example.com>

    This is a test message.
    END_OF_MESSAGE

    require 'net/smtp'
    Net::SMTP.start('your.smtp.server', 25) do |smtp|
      smtp.send_message msgstr,
                        'your@mail.address',
                        'his_address@example.com'
    end

### Closing the Session

You MUST close the SMTP session after sending messages, by calling the #finish
method:

    # using SMTP#finish
    smtp = Net::SMTP.start('your.smtp.server', 25)
    smtp.send_message msgstr, 'from@address', 'to@address'
    smtp.finish

You can also use the block form of SMTP.start/SMTP#start.  This closes the
SMTP session automatically:

    # using block form of SMTP.start
    Net::SMTP.start('your.smtp.server', 25) do |smtp|
      smtp.send_message msgstr, 'from@address', 'to@address'
    end

I strongly recommend this scheme.  This form is simpler and more robust.

### HELO domain

In almost all situations, you must provide a third argument to
SMTP.start/SMTP#start. This is the domain name which you are on (the host to
send mail from). It is called the "HELO domain". The SMTP server will judge
whether it should send or reject the SMTP session by inspecting the HELO
domain.

    Net::SMTP.start('your.smtp.server', 25,
                    'mail.from.domain') { |smtp| ... }

### SMTP Authentication

The Net::SMTP class supports three authentication schemes; PLAIN, LOGIN and
CRAM MD5.  (SMTP Authentication: [RFC2554]) To use SMTP authentication, pass
extra arguments to SMTP.start/SMTP#start.

    # PLAIN
    Net::SMTP.start('your.smtp.server', 25, 'mail.from.domain',
                    'Your Account', 'Your Password', :plain)
    # LOGIN
    Net::SMTP.start('your.smtp.server', 25, 'mail.from.domain',
                    'Your Account', 'Your Password', :login)

    # CRAM MD5
    Net::SMTP.start('your.smtp.server', 25, 'mail.from.domain',
                    'Your Account', 'Your Password', :cram_md5)

[Net::SMTP Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/net/smtp/rdoc/Net::SMTP.html)
