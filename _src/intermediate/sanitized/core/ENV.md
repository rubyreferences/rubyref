# ENV

ENV is a hash-like accessor for environment variables.

### Interaction with the Operating System

The ENV object interacts with the operating system's environment variables:

*   When you get the value for a name in ENV, the value is retrieved from
    among the current environment variables.

*   When you create or set a name-value pair in ENV, the name and value are
    immediately set in the environment variables.

*   When you delete a name-value pair in ENV, it is immediately deleted from
    the environment variables.


### Names and Values

Generally, a name or value is a String.

#### Valid Names and Values

Each name or value must be one of the following:

*   A String.
*   An object that responds to `#to_str` by returning a String, in which case
    that String will be used as the name or value.


#### Invalid Names and Values

A new name:

*   May not be the empty string:
        ENV[''] = '0'
        # Raises Errno::EINVAL (Invalid argument - ruby_setenv())

*   May not contain character `"="`:
        ENV['='] = '0'
        # Raises Errno::EINVAL (Invalid argument - ruby_setenv(=))


A new name or value:

*   May not be a non-String that does not respond to `#to_str`:

        ENV['foo'] = Object.new
        # Raises TypeError (no implicit conversion of Object into String)
        ENV[Object.new] = '0'
        # Raises TypeError (no implicit conversion of Object into String)

*   May not contain the NUL character `"\0"`:

        ENV['foo'] = "\0"
        # Raises ArgumentError (bad environment variable value: contains null byte)
        ENV["\0"] == '0'
        # Raises ArgumentError (bad environment variable name: contains null byte)

*   May not have an ASCII-incompatible encoding such as UTF-16LE or
    ISO-2022-JP:

        ENV['foo'] = '0'.force_encoding(Encoding::ISO_2022_JP)
        # Raises ArgumentError (bad environment variable name: ASCII incompatible encoding: ISO-2022-JP)
        ENV["foo".force_encoding(Encoding::ISO_2022_JP)] = '0'
        # Raises ArgumentError (bad environment variable name: ASCII incompatible encoding: ISO-2022-JP)


### About Ordering

ENV enumerates its name/value pairs in the order found in the operating
system's environment variables. Therefore the ordering of ENV content is
OS-dependent, and may be indeterminate.

This will be seen in:

*   A Hash returned by an ENV method.
*   An Enumerator returned by an ENV method.
*   An Array returned by ENV.keys, ENV.values, or ENV.to_a.
*   The String returned by ENV.inspect.
*   The Array returned by ENV.shift.
*   The name returned by ENV.key.


### About the Examples
Some methods in ENV return ENV itself. Typically, there are many environment
variables. It's not useful to display a large ENV in the examples here, so
most example snippets begin by resetting the contents of ENV:

*   ENV.replace replaces ENV with a new collection of entries.
*   ENV.clear empties ENV.


[ENV Reference](https://ruby-doc.org/core-2.7.0/ENV.html)