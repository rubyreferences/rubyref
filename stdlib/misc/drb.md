---
title: 'drb: Distributed Ruby'
prev: "/stdlib/misc/concurrency-utils.html"
next: "/stdlib/misc/dbm.html"
---


```ruby
require 'drb'
```

## DRb[](#drb)

dRuby is a distributed object system for Ruby. It is written in pure
Ruby and uses its own protocol. No add-in services are needed beyond
those provided by the Ruby runtime, such as TCP sockets. It does not
rely on or interoperate with other distributed object systems such as
CORBA, RMI, or .NET.

dRuby allows methods to be called in one Ruby process upon a Ruby object
located in another Ruby process, even on another machine. References to
objects can be passed between processes. Method arguments and return
values are dumped and loaded in marshalled format. All of this is done
transparently to both the caller of the remote method and the object
that it is called upon.

An object in a remote process is locally represented by a DRb::DRbObject
instance. This acts as a sort of proxy for the remote object. Methods
called upon this DRbObject instance are forwarded to its remote object.
This is arranged dynamically at run time. There are no statically
declared interfaces for remote objects, such as CORBA's IDL.

dRuby calls made into a process are handled by a DRb::DRbServer instance
within that process. This reconstitutes the method call, invokes it upon
the specified local object, and returns the value to the remote caller.
Any object can receive calls over dRuby. There is no need to implement a
special interface, or mixin special functionality. Nor, in the general
case, does an object need to explicitly register itself with a DRbServer
in order to receive dRuby calls.

One process wishing to make dRuby calls upon another process must
somehow obtain an initial reference to an object in the remote process
by some means other than as the return value of a remote method call, as
there is initially no remote object reference it can invoke a method
upon. This is done by attaching to the server by URI. Each DRbServer
binds itself to a URI such as 'druby://example.com:8787'. A DRbServer
can have an object attached to it that acts as the server's **front**
**object**. A DRbObject can be explicitly created from the server's URI.
This DRbObject's remote object will be the server's front object. This
front object can then return references to other Ruby objects in the
DRbServer's process.

Method calls made over dRuby behave largely the same as normal Ruby
method calls made within a process. Method calls with blocks are
supported, as are raising exceptions. In addition to a method's standard
errors, a dRuby call may also raise one of the dRuby-specific errors,
all of which are subclasses of DRb::DRbError.

Any type of object can be passed as an argument to a dRuby call or
returned as its return value. By default, such objects are dumped or
marshalled at the local end, then loaded or unmarshalled at the remote
end. The remote end therefore receives a copy of the local object, not a
distributed reference to it; methods invoked upon this copy are executed
entirely in the remote process, not passed on to the local original.
This has semantics similar to pass-by-value.

However, if an object cannot be marshalled, a dRuby reference to it is
passed or returned instead. This will turn up at the remote end as a
DRbObject instance. All methods invoked upon this remote proxy are
forwarded to the local object, as described in the discussion of
DRbObjects. This has semantics similar to the normal Ruby
pass-by-reference.

The easiest way to signal that we want an otherwise marshallable object
to be passed or returned as a DRbObject reference, rather than
marshalled and sent as a copy, is to include the DRb::DRbUndumped mixin
module.

dRuby supports calling remote methods with blocks. As blocks (or rather
the Proc objects that represent them) are not marshallable, the block
executes in the local, not the remote, context. Each value yielded to
the block is passed from the remote object to the local block, then the
value returned by each block invocation is passed back to the remote
execution context to be collected, before the collected values are
finally returned to the local context as the return value of the method
invocation.

### Examples of usage[](#examples-of-usage)

For more dRuby samples, see the `samples` directory in the full dRuby
distribution.

#### dRuby in client/server mode[](#druby-in-clientserver-mode)

This illustrates setting up a simple client-server drb system. Run the
server and client code in different terminals, starting the server code
first.

##### Server code[](#server-code)


```ruby
require 'drb/drb'

# The URI for the server to connect to
URI="druby://localhost:8787"

class TimeServer

  def get_current_time
    return Time.now
  end

end

# The object that handles requests on the server
FRONT_OBJECT=TimeServer.new

$SAFE = 1   # disable eval() and friends

DRb.start_service(URI, FRONT_OBJECT)
# Wait for the drb server thread to finish before exiting.
DRb.thread.join
```

##### Client code[](#client-code)


```ruby
require 'drb/drb'

# The URI to connect to
SERVER_URI="druby://localhost:8787"

# Start a local DRbServer to handle callbacks.
#
# Not necessary for this small example, but will be required
# as soon as we pass a non-marshallable object as an argument
# to a dRuby call.
#
# Note: this must be called at least once per process to take any effect.
# This is particularly important if your application forks.
DRb.start_service

timeserver = DRbObject.new_with_uri(SERVER_URI)
puts timeserver.get_current_time
```

#### Remote objects under dRuby[](#remote-objects-under-druby)

This example illustrates returning a reference to an object from a dRuby
call. The Logger instances live in the server process. References to
them are returned to the client process, where methods can be invoked
upon them. These methods are executed in the server process.

##### Server code[](#server-code-1)


```ruby
require 'drb/drb'

URI="druby://localhost:8787"

class Logger

    # Make dRuby send Logger instances as dRuby references,
    # not copies.
    include DRb::DRbUndumped

    def initialize(n, fname)
        @name = n
        @filename = fname
    end

    def log(message)
        File.open(@filename, "a") do |f|
            f.puts("#{Time.now}: #{@name}: #{message}")
        end
    end

end

# We have a central object for creating and retrieving loggers.
# This retains a local reference to all loggers created.  This
# is so an existing logger can be looked up by name, but also
# to prevent loggers from being garbage collected.  A dRuby
# reference to an object is not sufficient to prevent it being
# garbage collected!
class LoggerFactory

    def initialize(bdir)
        @basedir = bdir
        @loggers = {}
    end

    def get_logger(name)
        if !@loggers.has_key? name
            # make the filename safe, then declare it to be so
            fname = name.gsub(/[.\/\\\:]/, "_").untaint
            @loggers[name] = Logger.new(name, @basedir + "/" + fname)
        end
        return @loggers[name]
    end

end

FRONT_OBJECT=LoggerFactory.new("/tmp/dlog")

$SAFE = 1   # disable eval() and friends

DRb.start_service(URI, FRONT_OBJECT)
DRb.thread.join
```

##### Client code[](#client-code-1)


```ruby
require 'drb/drb'

SERVER_URI="druby://localhost:8787"

DRb.start_service

log_service=DRbObject.new_with_uri(SERVER_URI)

["loga", "logb", "logc"].each do |logname|

    logger=log_service.get_logger(logname)

    logger.log("Hello, world!")
    logger.log("Goodbye, world!")
    logger.log("=== EOT ===")

end
```

### Security[](#security)

As with all network services, security needs to be considered when using
dRuby. By allowing external access to a Ruby object, you are not only
allowing outside clients to call the methods you have defined for that
object, but by default to execute arbitrary Ruby code on your server.
Consider the following:


```ruby
# !!! UNSAFE CODE !!!
ro = DRbObject::new_with_uri("druby://your.server.com:8989")
class << ro
  undef :instance_eval  # force call to be passed to remote object
end
ro.instance_eval("`rm -rf *`")
```

The dangers posed by instance\_eval and friends are such that a
DRbServer should generally be run with $SAFE set to at least level 1.
This will disable eval() and related calls on strings passed across the
wire. The sample usage code given above follows this practice.

A DRbServer can be configured with an access control list to selectively
allow or deny access from specified IP addresses. The main druby
distribution provides the ACL class for this purpose. In general, this
mechanism should only be used alongside, rather than as a replacement
for, a good firewall.

### dRuby internals[](#druby-internals)

dRuby is implemented using three main components: a remote method call
marshaller/unmarshaller; a transport protocol; and an ID-to-object
mapper. The latter two can be directly, and the first indirectly,
replaced, in order to provide different behaviour and capabilities.

Marshalling and unmarshalling of remote method calls is performed by a
DRb::DRbMessage instance. This uses the Marshal module to dump the
method call before sending it over the transport layer, then
reconstitute it at the other end. There is normally no need to replace
this component, and no direct way is provided to do so. However, it is
possible to implement an alternative marshalling scheme as part of an
implementation of the transport layer.

The transport layer is responsible for opening client and server network
connections and forwarding dRuby request across them. Normally, it uses
DRb::DRbMessage internally to manage marshalling and unmarshalling. The
transport layer is managed by DRb::DRbProtocol. Multiple protocols can
be installed in DRbProtocol at the one time; selection between them is
determined by the scheme of a dRuby URI. The default transport protocol
is selected by the scheme 'druby:', and implemented by
DRb::DRbTCPSocket. This uses plain TCP/IP sockets for communication. An
alternative protocol, using UNIX domain sockets, is implemented by
DRb::DRbUNIXSocket in the file drb/unix.rb, and selected by the scheme
'drbunix:'. A sample implementation over HTTP can be found in the
samples accompanying the main dRuby distribution.

The ID-to-object mapping component maps dRuby object ids to the objects
they refer to, and vice versa. The implementation to use can be
specified as part of a DRb::DRbServer's configuration. The default
implementation is provided by DRb::DRbIdConv. It uses an object's
ObjectSpace id as its dRuby id. This means that the dRuby reference to
that object only remains meaningful for the lifetime of the object's
process and the lifetime of the object within that process. A modified
implementation is provided by DRb::TimerIdConv in the file
drb/timeridconv.rb. This implementation retains a local reference to all
objects exported over dRuby for a configurable period of time
(defaulting to ten minutes), to prevent them being garbage-collected
within this time. Another sample implementation is provided in
sample/name.rb in the main dRuby distribution. This allows objects to
specify their own id or "name". A dRuby reference can be made persistent
across processes by having each process register an object using the
same dRuby name.

<a href='https://ruby-doc.org/stdlib-2.5.0/libdoc/drb/rdoc/DRb.html'
class='ruby-doc remote' target='_blank'>DRb Reference</a>

