---
title: syslog
prev: "/stdlib/cli/readline.html"
next: "/stdlib/cli/shell.html"
---


```ruby
require 'syslog'
```

# Syslog

The syslog package provides a Ruby interface to the POSIX system logging
facility.

Syslog messages are typically passed to a central logging daemon. The
daemon may filter them; route them into different files (usually found
under /var/log); place them in SQL databases; forward them to
centralized logging servers via TCP or UDP; or even alert the system
administrator via email, pager or text message.

Unlike application-level logging via Logger or Log4r, syslog is designed
to allow secure tamper-proof logging.

The syslog protocol is standardized in RFC 5424.

[Syslog
Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/syslog/rdoc/Syslog.html)

