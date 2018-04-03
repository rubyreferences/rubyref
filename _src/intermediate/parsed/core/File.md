# File

A `File` is an abstraction of any file object accessible by the program and is
closely associated with class `IO`. `File` includes the methods of module
`FileTest` as class methods, allowing you to write (for example)
`File.exist?("foo")`.

In the description of File methods, *permission bits* are a platform-specific
set of bits that indicate permissions of a file. On Unix-based systems,
permissions are viewed as a set of three octets, for the owner, the group, and
the rest of the world. For each of these entities, permissions may be set to
read, write, or execute the file:

The permission bits `0644` (in octal) would thus be interpreted as read/write
for owner, and read-only for group and other. Higher-order bits may also be
used to indicate the type of file (plain, directory, pipe, socket, and so on)
and various other special features. If the permissions are for a directory,
the meaning of the execute bit changes; when set the directory can be
searched.

On non-Posix operating systems, there may be only the ability to make a file
read-only or read-write. In this case, the remaining permission bits will be
synthesized to resemble typical values. For instance, on Windows NT the
default permission bits are `0644`, which means read/write for owner,
read-only for all others. The only change that can be made is to make the file
read-only, which is reported as `0444`.

Various constants for the methods in File can be found in File::Constants.

[File Reference](https://ruby-doc.org/core-2.5.0/File.html)
