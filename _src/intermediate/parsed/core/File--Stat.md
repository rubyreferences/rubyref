# File::Stat

Objects of class `File::Stat` encapsulate common status information for `File`
objects. The information is recorded at the moment the `File::Stat` object is
created; changes made to the file after that point will not be reflected.
`File::Stat` objects are returned by `IO#stat`, `File::stat`, `File#lstat`,
and `File::lstat`. Many of these methods return platform-specific values, and
not all values are meaningful on all systems. See also `Kernel#test`.

[File::Stat Reference](https://ruby-doc.org/core-2.6/File/Stat.html)
