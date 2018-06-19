# Net::IMAP

Net::IMAP implements Internet Message Access Protocol (IMAP) client
functionality.  The protocol is described in [IMAP].

## IMAP Overview

An IMAP client connects to a server, and then authenticates itself using
either `#authenticate`() or `#login`().  Having authenticated itself, there is a
range of commands available to it.  Most work with mailboxes, which may be
arranged in an hierarchical namespace, and each of which contains zero or more
messages.  How this is implemented on the server is implementation-dependent;
on a UNIX server, it will frequently be implemented as files in mailbox format
within a hierarchy of directories.

To work on the messages within a mailbox, the client must first select that
mailbox, using either `#select`() or (for read-only access) `#examine`().  Once
the client has successfully selected a mailbox, they enter *selected* state,
and that mailbox becomes the *current* mailbox, on which mail-item related
commands implicitly operate.

Messages have two sorts of identifiers: message sequence numbers and UIDs.

Message sequence numbers number messages within a mailbox from 1 up to the
number of items in the mailbox.  If a new message arrives during a session, it
receives a sequence number equal to the new size of the mailbox.  If messages
are expunged from the mailbox, remaining messages have their sequence numbers
"shuffled down" to fill the gaps.

UIDs, on the other hand, are permanently guaranteed not to identify another
message within the same mailbox, even if the existing message is deleted. 
UIDs are required to be assigned in ascending (but not necessarily sequential)
order within a mailbox; this means that if a non-IMAP client rearranges the
order of mailitems within a mailbox, the UIDs have to be reassigned.  An IMAP
client thus cannot rearrange message orders.

## Examples of Usage

### List sender and subject of all recent messages in the default mailbox

    imap = Net::IMAP.new('mail.example.com')
    imap.authenticate('LOGIN', 'joe_user', 'joes_password')
    imap.examine('INBOX')
    imap.search(["RECENT"]).each do |message_id|
      envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
      puts "#{envelope.from[0].name}: \t#{envelope.subject}"
    end

### Move all messages from April 2003 from "Mail/sent-mail" to "Mail/sent-apr03"

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

## Thread Safety

Net::IMAP supports concurrent threads. For example,

    imap = Net::IMAP.new("imap.foo.net", "imap2")
    imap.authenticate("cram-md5", "bar", "password")
    imap.select("inbox")
    fetch_thread = Thread.start { imap.fetch(1..-1, "UID") }
    search_result = imap.search(["BODY", "hello"])
    fetch_result = fetch_thread.value
    imap.disconnect

This script invokes the FETCH command and the SEARCH command concurrently.

## Errors

An IMAP server can send three different types of responses to indicate
failure:

* NO: the attempted command could not be successfully completed.  For instance,
    the username/password used for logging in are incorrect; the selected
    mailbox does not exist; etc.

* BAD: the request from the client does not follow the server's understanding of
    the IMAP protocol.  This includes attempting commands from the wrong
    client state; for instance, attempting to perform a SEARCH command without
    having SELECTed a current mailbox.  It can also signal an internal server
    failure (such as a disk crash) has occurred.

* BYE: the server is saying goodbye.  This can be part of a normal logout
    sequence, and can be used as part of a login sequence to indicate that the
    server is (for some reason) unwilling to accept your connection.  As a
    response to any other command, it indicates either that the server is
    shutting down, or that the server is timing out the client connection due
    to inactivity.


These three error response are represented by the errors
Net::IMAP::NoResponseError, Net::IMAP::BadResponseError, and
Net::IMAP::ByeResponseError, all of which are subclasses of
Net::IMAP::ResponseError.  Essentially, all methods that involve sending a
request to the server can generate one of these errors. Only the most
pertinent instances have been documented below.

Because the IMAP class uses Sockets for communication, its methods are also
susceptible to the various errors that can occur when working with sockets. 
These are generally represented as Errno errors.  For instance, any method
that involves sending a request to the server and/or receiving a response from
it could raise an Errno::EPIPE error if the network connection unexpectedly
goes down.  See the socket(7), ip(7), tcp(7), socket(2), connect(2), and
associated man pages.

Finally, a Net::IMAP::DataFormatError is thrown if low-level data is found to
be in an incorrect format (for instance, when converting between UTF-8 and
UTF-16), and Net::IMAP::ResponseParseError is thrown if a server response is
non-parseable.

## References

    1.  Crispin, "INTERNET MESSAGE ACCESS PROTOCOL - VERSION 4rev1",

    RFC 2060, December 1996.  (Note: since obsoleted by RFC 3501)

* [LANGUAGE-TAGS]: Alvestrand, H., "Tags for the Identification of Languages", RFC 1766,
    March 1995.

* [MD5]: Myers, J., and M. Rose, "The Content-MD5 Header Field", RFC 1864, October
    1995.

* [MIME-IMB]: Freed, N., and N. Borenstein, "MIME (Multipurpose Internet Mail
    Extensions) Part One: Format of Internet Message Bodies", RFC 2045,
    November 1996.

* [RFC-822]: Crocker, D., "Standard for the Format of ARPA Internet Text Messages", STD
    11, RFC 822, University of Delaware, August 1982.

* [RFC-2087]: Myers, J., "IMAP4 QUOTA extension", RFC 2087, January 1997.

* [RFC-2086]: Myers, J., "IMAP4 ACL extension", RFC 2086, January 1997.

* [RFC-2195]: Klensin, J., Catoe, R., and Krumviede, P., "IMAP/POP AUTHorize Extension
    for Simple Challenge/Response", RFC 2195, September 1997.

* [SORT-THREAD-EXT]: Crispin, M., "INTERNET MESSAGE ACCESS PROTOCOL - SORT and THREAD
    Extensions", draft-ietf-imapext-sort, May 2003.

* [OSSL]: http://www.openssl.org

* [RSSL]: http://savannah.gnu.org/projects/rubypki

* [UTF7]: Goldsmith, D. and Davis, M., "UTF-7: A Mail-Safe Transformation Format of
    Unicode", RFC 2152, May 1997.


[Net::IMAP Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/net/imap/rdoc/Net/IMAP.html)