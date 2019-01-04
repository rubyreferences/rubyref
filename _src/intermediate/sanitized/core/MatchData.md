# MatchData

`MatchData` encapsulates the result of matching a Regexp against string. It is
returned by `Regexp#match` and `String#match`, and also stored in a global
variable returned by Regexp.last_match.

Usage:

    url = 'https://docs.ruby-lang.org/en/2.5.0/MatchData.html'
    m = url.match(/(\d\.?)+/)   # => #<MatchData "2.5.0" 1:"0">
    m.string                    # => "https://docs.ruby-lang.org/en/2.5.0/MatchData.html"
    m.regexp                    # => /(\d\.?)+/
    # entire matched substring:
    m[0]                        # => "2.5.0"

    # Working with unnamed captures
    m = url.match(%r{([^/]+)/([^/]+)\.html$})
    m.captures                  # => ["2.5.0", "MatchData"]
    m[1]                        # => "2.5.0"
    m.values_at(1, 2)           # => ["2.5.0", "MatchData"]

    # Working with named captures
    m = url.match(%r{(?<version>[^/]+)/(?<module>[^/]+)\.html$})
    m.captures                  # => ["2.5.0", "MatchData"]
    m.named_captures            # => {"version"=>"2.5.0", "module"=>"MatchData"}
    m[:version]                 # => "2.5.0"
    m.values_at(:version, :module)
                                # => ["2.5.0", "MatchData"]
    # Numerical indexes are working, too
    m[1]                        # => "2.5.0"
    m.values_at(1, 2)           # => ["2.5.0", "MatchData"]

## Global variables equivalence

Parts of last `MatchData` (returned by Regexp.last_match) are also aliased as
global variables:

*   `$~` is `Regexp.last_match`;
*   `$&` is `Regexp.last_match[0]`;
*   `$1`, `$2`, and so on are `Regexp.last_match[i]` (captures by number);
*   `$`` is `Regexp.last_match.pre_match`;
*   `$'` is `Regexp.last_match.post_match`;
*   `$+` is `Regexp.last_match[-1]` (the last capture).


See also "Special global variables" section in Regexp documentation.

[MatchData Reference](https://ruby-doc.org/core-2.6/MatchData.html)