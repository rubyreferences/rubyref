# ARGF

`ARGF` is a stream designed for use in scripts that process files given
as command-line arguments or passed in via STDIN.

The arguments passed to your script are stored in the `ARGV` Array, one
argument per element. `ARGF` assumes that any arguments that aren't
filenames have been removed from `ARGV`. For example:


```ruby
$ ruby argf.rb --verbose file1 file2

ARGV  #=> ["--verbose", "file1", "file2"]
option = ARGV.shift #=> "--verbose"
ARGV  #=> ["file1", "file2"]
```

You can now use `ARGF` to work with a concatenation of each of these
named files. For instance, `ARGF.read` will return the contents of
*file1* followed by the contents of *file2*.

After a file in `ARGV` has been read `ARGF` removes it from the Array.
Thus, after all files have been read `ARGV` will be empty.

You can manipulate `ARGV` yourself to control what `ARGF` operates on.
If you remove a file from `ARGV`, it is ignored by `ARGF`; if you add
files to `ARGV`, they are treated as if they were named on the command
line. For example:


```ruby
ARGV.replace ["file1"]
ARGF.readlines # Returns the contents of file1 as an Array
ARGV           #=> []
ARGV.replace ["file2", "file3"]
ARGF.read      # Returns the contents of file2 and file3
```

If `ARGV` is empty, `ARGF` acts as if it contained STDIN, i.e. the data
piped to your script. For example:


```ruby
$ echo "glark" | ruby -e 'p ARGF.read'
"glark\n"
```

[ARGF Reference](http://ruby-doc.org/core-2.5.0/ARGF.html)



## ENV

ENV is a hash-like accessor for environment variables.

[ENV Reference](http://ruby-doc.org/core-2.5.0/ENV.html)

