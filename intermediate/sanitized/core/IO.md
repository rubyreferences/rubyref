# IO

The IO class is the basis for all input and output in Ruby. An I/O stream may
be *duplexed* (that is, bidirectional), and so may use more than one native
operating system stream.

Many of the examples in this section use the File class, the only standard
subclass of IO. The two classes are closely associated.  Like the File class,
the Socket library subclasses from IO (such as TCPSocket or UDPSocket).

The `Kernel#open` method can create an IO (or File) object for these types of
arguments:

*   A plain string represents a filename suitable for the underlying operating
    system.

*   A string starting with `"|"` indicates a subprocess. The remainder of the
    string following the `"|"` is invoked as a process with appropriate
    input/output channels connected to it.

*   A string equal to `"|-"` will create another Ruby instance as a
    subprocess.


The IO may be opened with different file modes (read-only, write-only) and
encodings for proper conversion.  See IO.new for these options.  See
Kernel#open for details of the various command formats described above.

IO.popen, the Open3 library, or  `Process#spawn` may also be used to communicate
with subprocesses through an IO.

Ruby will convert pathnames between different operating system conventions if
possible.  For instance, on a Windows system the filename
`"/gumby/ruby/test.rb"` will be opened as `"\gumby\ruby\test.rb"`.  When
specifying a Windows-style filename in a Ruby string, remember to escape the
backslashes:

    "C:\\gumby\\ruby\\test.rb"

Our examples here will use the Unix-style forward slashes; File::ALT_SEPARATOR
can be used to get the platform-specific separator character.

The global constant ARGF (also accessible as `$<`) provides an IO-like stream
which allows access to all files mentioned on the command line (or STDIN if no
files are mentioned). `ARGF#path` and its alias `ARGF#filename` are provided to
access the name of the file currently being read.

## io/console

The io/console extension provides methods for interacting with the console. 
The console can be accessed from IO.console or the standard input/output/error
IO objects.

Requiring io/console adds the following methods:

*   IO::console
*   `IO#raw`
*   `IO#raw!`
*   `IO#cooked`
*   `IO#cooked!`
*   `IO#getch`
*   `IO#echo=`
*   `IO#echo?`
*   `IO#noecho`
*   `IO#winsize`
*   `IO#winsize=`
*   `IO#iflush`
*   `IO#ioflush`
*   `IO#oflush`


Example:

    require 'io/console'
    rows, columns = $stdout.winsize
    puts "Your screen is #{columns} wide and #{rows} tall"