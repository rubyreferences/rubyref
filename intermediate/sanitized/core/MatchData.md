# MatchData

`MatchData` is the type of the special variable `$~`, and is the type of the
object returned by `Regexp#match` and `Regexp.last_match`. It encapsulates all
the results of a pattern match, results normally accessed through the special
variables `$&`, `$``, `$``, `$1`, `$2`, and so on.