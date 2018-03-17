# REXML

REXML is an XML toolkit for [Ruby][1], in Ruby.

REXML is a *pure* Ruby, XML 1.0 conforming, [non-validating][2] toolkit
with an intuitive API. REXML passes 100% of the non-validating Oasis
[tests][3], and provides tree, stream, SAX2, pull, and lightweight APIs.
REXML also includes a full [XPath][4] 1.0 implementation. Since Ruby
1.8, REXML is included in the standard Ruby distribution.

Main page
: http://www.germane-software.com/software/rexml Author
: Sean Russell <serATgermaneHYPHENsoftwareDOTcom>
  Date</serATgermaneHYPHENsoftwareDOTcom>
: 2008/019 Version
: 3\.1.7.3

This API documentation can be downloaded from the REXML home page, or
can be accessed [online][5]

A tutorial is available in the REXML distribution in docs/tutorial.html,
or can be accessed [online][6]



[1]: http://www.ruby-lang.org
[2]: http://www.w3.org/TR/2004/REC-xml-20040204/\#sec-conformance
[3]: http://www.oasis-open.org/committees/xml-conformance/xml-test-suite.sh
tml
[4]: http://www.w3c.org/tr/xpath
[5]: http://www.germane-software.com/software/rexml_doc
[6]: http://www.germane-software.com/software/rexml/docs/tutorial.html


## RSS

## RSS reading and writing

Really Simple Syndication (RSS) is a family of formats that describe
'feeds,' specially constructed XML documents that allow an interested
person to subscribe and receive updates from a particular web service.
This portion of the standard library provides tooling to read and create
these feeds.

The standard library supports RSS 0.91, 1.0, 2.0, and Atom, a related
format. Here are some links to the standards documents for these
formats:

* RSS
  * [0.9.1][1]
  * [1.0][2]
  * [2.0][3]

* [Atom][4]

### Consuming RSS

If you'd like to read someone's RSS feed with your Ruby code, you've
come to the right place. It's really easy to do this, but we'll need the
help of open-uri:


```ruby
require 'rss'
require 'open-uri'

url = 'http://www.ruby-lang.org/en/feeds/news.rss'
open(url) do |rss|
  feed = RSS::Parser.parse(rss)
  puts "Title: #{feed.channel.title}"
  feed.items.each do |item|
    puts "Item: #{item.title}"
  end
end
```

As you can see, the workhorse is RSS::Parser#parse, which takes the
source of the feed and a parameter that performs validation on the feed.
We get back an object that has all of the data from our feed, accessible
through methods. This example shows getting the title out of the channel
element, and looping through the list of items.

### Producing RSS

Producing our own RSS feeds is easy as well. Let's make a very basic
feed:


```ruby
require "rss"

rss = RSS::Maker.make("atom") do |maker|
  maker.channel.author = "matz"
  maker.channel.updated = Time.now.to_s
  maker.channel.about = "http://www.ruby-lang.org/en/feeds/news.rss"
  maker.channel.title = "Example Feed"

  maker.items.new_item do |item|
    item.link = "http://www.ruby-lang.org/en/news/2010/12/25/ruby-1-9-2-p136-is-released/"
    item.title = "Ruby 1.9.2-p136 is released"
    item.updated = Time.now.to_s
  end
end

puts rss
```

As you can see, this is a very Builder-like DSL. This code will spit out
an Atom feed with one item. If we needed a second item, we'd make
another block with maker.items.new\_item and build a second one.

### Copyright

Copyright (c) 2003-2007 Kouhei Sutou
[kou@cozmixng.org](mailto:kou@cozmixng.org)

You can redistribute it and/or modify it under the same terms as Ruby.

There is an additional tutorial by the author of RSS at:
http://www.cozmixng.org/~rwiki/?cmd=view;name=RSS+Parser%3A%3ATutorial.en



[1]: http://www.rssboard.org/rss-0-9-1-netscape
[2]: http://web.resource.org/rss/1.0/
[3]: http://www.rssboard.org/rss-specification
[4]: http://tools.ietf.org/html/rfc4287
