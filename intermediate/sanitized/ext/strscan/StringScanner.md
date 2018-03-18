# StringScanner

StringScanner provides for lexical scanning operations on a String.  Here is
an example of its usage:

    s = StringScanner.new('This is an example string')
    s.eos?               # -> false

    p s.scan(/\w+/)      # -> "This"
    p s.scan(/\w+/)      # -> nil
    p s.scan(/\s+/)      # -> " "
    p s.scan(/\s+/)      # -> nil
    p s.scan(/\w+/)      # -> "is"
    s.eos?               # -> false

    p s.scan(/\s+/)      # -> " "
    p s.scan(/\w+/)      # -> "an"
    p s.scan(/\s+/)      # -> " "
    p s.scan(/\w+/)      # -> "example"
    p s.scan(/\s+/)      # -> " "
    p s.scan(/\w+/)      # -> "string"
    s.eos?               # -> true

    p s.scan(/\s+/)      # -> nil
    p s.scan(/\w+/)      # -> nil

Scanning a string means remembering the position of a *scan pointer*, which is
just an index.  The point of scanning is to move forward a bit at a time, so
matches are sought after the scan pointer; usually immediately after it.

Given the string "test string", here are the pertinent scan pointer positions:

      t e s t   s t r i n g
    0 1 2 ...             1
                          0

When you `#scan` for a pattern (a regular expression), the match must occur at
the character after the scan pointer.  If you use `#scan_until`, then the match
can occur anywhere after the scan pointer.  In both cases, the scan pointer
moves *just beyond* the last character of the match, ready to scan again from
the next character onwards.  This is demonstrated by the example above.

## Method Categories

There are other methods besides the plain scanners.  You can look ahead in the
string without actually scanning.  You can access the most recent match. You
can modify the string being scanned, reset or terminate the scanner, find out
or change the position of the scan pointer, skip ahead, and so on.

### Advancing the Scan Pointer

*   `#getch`
*   `#get_byte`
*   `#scan`
*   `#scan_until`
*   `#skip`
*   `#skip_until`


### Looking Ahead

*   `#check`
*   `#check_until`
*   `#exist?`
*   `#match?`
*   `#peek`


### Finding Where we Are

*   `#beginning_of_line?` (#bol?)
*   `#eos?`
*   `#rest?`
*   `#rest_size`
*   `#pos`


### Setting Where we Are

*   `#reset`
*   `#terminate`
*   `#pos=`


### Match Data

*   `#matched`
*   `#matched?`
*   `#matched_size`

    
:       

*   `#pre_match`
*   `#post_match`


### Miscellaneous

*   <<
*   `#concat`
*   `#string`
*   `#string=`
*   `#unscan`


There are aliases to several of the methods.