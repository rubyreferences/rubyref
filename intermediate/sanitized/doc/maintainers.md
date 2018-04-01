# Maintainers

This page describes the current module, library, and extension maintainers of
Ruby.

## Module Maintainers

A module maintainer is responsible for a certain part of Ruby.

*   The maintainer fixes bugs of the part. Particularly, they should fix
    security vulnerabilities as soon as possible.

*   They handle issues related the module on the Redmine or ML.
*   They may be discharged by the 3 months rule [ruby-core:25764].
*   They have commit right to Ruby's repository to modify their part in the
    repository.

*   They have "developer" role on the Redmine to modify issues.
*   They have authority to decide the feature of their part. But they should
    always respect discussions on ruby-core/ruby-dev.


A submaintainer of a module is like a maintainer. But The submaintainer does
not have authority to change/add a feature on his/her part. They need
consensus on ruby-core/ruby-dev before changing/adding. Some of submaintainers
have commit right, others don't.

### Language core features including security

Yukihiro Matsumoto (matz)

### Evaluator

Koichi Sasada (ko1)

### Core classes

Yukihiro Matsumoto (matz)

### Documentation

Zachary Scott (zzak)

## Standard Library Maintainers

### Libraries

* lib/English.rb: *unmaintained*
* lib/abbrev.rb: Akinori MUSHA (knu)
* lib/base64.rb: Yusuke Endoh (mame)
* lib/benchmark.rb: *unmaintained*
* lib/cgi.rb, lib/cgi/*: Takeyuki Fujioka (xibbar)
* lib/drb.rb, lib/drb/*: Masatoshi SEKI (seki)
* lib/debug.rb: *unmaintained*
* lib/delegate.rb: *unmaintained*
* lib/e2mmap.rb: Keiju ISHITSUKA (keiju)
* lib/erb.rb: Masatoshi SEKI (seki), Takashi Kokubun (k0kubun)
* lib/find.rb: Kazuki Tsujimoto (ktsj)
* lib/forwardable.rb: Keiju ISHITSUKA (keiju)
* lib/getoptlong.rb: *unmaintained*
* lib/ipaddr.rb: Akinori MUSHA (knu)
* lib/irb.rb, lib/irb/*: Keiju ISHITSUKA (keiju)
* lib/logger.rb: Naotoshi Seo (sonots)
* lib/matrix.rb: Marc-Andre Lafortune (marcandre)
* lib/mkmf.rb: *unmaintained*
* lib/monitor.rb: Shugo Maeda (shugo)
* lib/mutex_m.rb: Keiju ISHITSUKA (keiju)
* lib/net/ftp.rb: Shugo Maeda (shugo)
* lib/net/imap.rb: Shugo Maeda (shugo)
* lib/net/http.rb, lib/net/https.rb: NARUSE, Yui (naruse)
* lib/net/pop.rb: *unmaintained*
* lib/net/protocol.rb: *unmaintained*
* lib/net/smtp.rb: *unmaintained*
* lib/observer.rb: *unmaintained*
* lib/open-uri.rb: Tanaka Akira (akr)
* lib/open3.rb: *unmaintained*
* lib/optparse.rb, lib/optparse/*: Nobuyuki Nakada (nobu)
* lib/ostruct.rb: Marc-Andre Lafortune (marcandre)
* lib/pp.rb: Tanaka Akira (akr)
* lib/prettyprint.rb: Tanaka Akira (akr)
* lib/prime.rb: Yuki Sonoda (yugui)
* lib/profile.rb: *unmaintained*
* lib/profiler.rb: *unmaintained*
* lib/pstore.rb: *unmaintained*
* lib/racc/*: Aaron Patterson (tenderlove)
* lib/resolv-replace.rb: Tanaka Akira (akr)
* lib/resolv.rb: Tanaka Akira (akr)
* lib/rexml/*: Kouhei Sutou (kou)
* lib/rinda/*: Masatoshi SEKI (seki)
* lib/rss.rb, lib/rss/*: Kouhei Sutou (kou)
* lib/rubygems.rb, lib/ubygems.rb, lib/rubygems/*: Eric Hodel (drbrain), Hiroshi SHIBATA (hsbt)
    https://github.com/rubygems/rubygems

* lib/set.rb: Akinori MUSHA (knu)
* lib/securerandom.rb: Tanaka Akira (akr)
* lib/shell.rb, lib/shell/*: Keiju ISHITSUKA (keiju)
* lib/shellwords.rb: Akinori MUSHA (knu)
* lib/singleton.rb: Yukihiro Matsumoto (matz)
* lib/sync.rb: Keiju ISHITSUKA (keiju)
* lib/tempfile.rb: *unmaintained*
* lib/tmpdir.rb: *unmaintained*
* lib/thwait.rb: Keiju ISHITSUKA (keiju)
* lib/time.rb: Tanaka Akira (akr)
* lib/timeout.rb: Yukihiro Matsumoto (matz)
* lib/tracer.rb: Keiju ISHITSUKA (keiju)
* lib/tsort.rb: Tanaka Akira (akr)
* lib/un.rb: WATANABE Hirofumi (eban)
* lib/unicode_normalize.rb, lib/unicode_normalize/*: Martin J. Dürst
* lib/uri.rb, lib/uri/*: YAMADA, Akira (akira)
* lib/weakref.rb: *unmaintained*
* lib/yaml.rb, lib/yaml/*: Aaron Patterson (tenderlove), Hiroshi SHIBATA (hsbt)


### Extensions

* ext/cgi: Nobuyoshi Nakada (nobu)
* ext/continuation: Koichi Sasada (ko1)
* ext/coverage: Yusuke Endoh (mame)
* ext/digest, ext/digest/*: Akinori MUSHA (knu)
* ext/fiber: Koichi Sasada (ko1)
* ext/io/nonblock: Nobuyuki Nakada (nobu)
* ext/io/wait: Nobuyuki Nakada (nobu)
* ext/nkf: NARUSE, Yui (narse)
* ext/objspace: *unmaintained*
* ext/pathname: Tanaka Akira (akr)
* ext/pty: *unmaintained*
* ext/racc: Aaron Patterson (tenderlove)
* ext/readline: TAKAO Kouji (kouji)
* ext/ripper: *unmaintained*
    *   Tanaka Akira (akr)
    *   API change needs matz's approval

* ext/syslog: Akinori MUSHA (knu)
* ext/win32: NAKAMURA Usaku (usa)
* ext/win32ole: Masaki Suketa (suke)


## Default gems Maintainers

### Libraries

* lib/cmath.rb: *unmaintained* https://github.com/ruby/cmath
* lib/csv.rb: James Edward Gray II (jeg2) https://github.com/ruby/csv
* lib/fileutils.rb: *unmaintained* https://github.com/ruby/fileutils
* lib/rdoc.rb, lib/rdoc/*: Eric Hodel (drbrain), Hiroshi SHIBATA (hsbt) https://github.com/ruby/rdoc
* lib/scanf.rb: David A. Black (dblack) https://github.com/ruby/scanf
* lib/webrick.rb, lib/webrick/*: Eric Wong (normalperson) https://bugs.ruby-lang.org/


### Extensions

* ext/bigdecimal: Kenta Murata (mrkn) https://github.com/ruby/bigdecimal
* ext/date: *unmaintained* https://github.com/ruby/date
* ext/dbm: *unmaintained* https://github.com/ruby/dbm
* ext/etc: *unmaintained* https://github.com/ruby/etc
* ext/fcntl: *unmaintained* https://github.com/ruby/fcntl
* ext/fiddle: Aaron Patterson (tenderlove) https://github.com/ruby/fiddle
* ext/gdbm: Yukihiro Matsumoto (matz) https://github.com/ruby/gdbm
* ext/io/console: Nobuyuki Nakada (nobu) https://github.com/ruby/io-console
* ext/json: NARUSE, Yui (naruse), Hiroshi SHIBATA (hsbt) https://github.com/flori/json
* ext/openssl: Kazuki Yamaguchi (rhe) https://github.com/ruby/openssl
* ext/psych: Aaron Patterson (tenderlove), Hiroshi SHIBATA(hsbt)
    https://github.com/ruby/psych

* ext/sdbm: Yukihiro Matsumoto (matz) https://github.com/ruby/sdbm
* ext/stringio: Nobuyuki Nakada (nobu) https://github.com/ruby/stringio
* ext/strscan: *unmaintained* https://github.com/ruby/strscan
* ext/zlib: *unmaintained* https://github.com/ruby/zlib


## Bundled gems upstream repositories

* did_you_mean: https://github.com/yuki24/did_you_mean
* minitest: https://github.com/seattlerb/minitest
* net-telnet: https://github.com/ruby/net-telnet
* power_assert: https://github.com/k-tsj/power_assert
* rake: https://github.com/ruby/rake
* test-unit: https://github.com/test-unit/test-unit
* xmlrpc: https://github.com/ruby/xmlrpc