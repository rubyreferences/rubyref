---
title: Libraries
prev: "/developing.html"
next: "/developing/irb.html"
---

## Libraries



As most programming languages, Ruby leverages a wide set of third-party
libraries.

Nearly all of these libraries are released in the form of a **gem**, a
packaged library or application that can be installed with a tool called
<a href='https://rubygems.org/' class='remote'
target='_blank'><strong>RubyGems</strong></a>.

RubyGems is a Ruby packaging system designed to facilitate the creation,
sharing and installation of libraries (in some ways, it is a
distribution packaging system similar to, say, `apt-get`, but targeted
at Ruby software). Ruby comes with RubyGems by default since version
1.9, previous Ruby versions require RubyGems to be <a
href='https://rubygems.org/pages/download/' class='remote'
target='_blank'>installed by hand</a>.

Some other libraries are released as archived (.zip or .tar.gz)
directories of **source code**. Installation processes may vary,
typically a `README` or `INSTALL` file is available with instructions.

Let’s take a look at finding libraries and installing them for your own
use.

#### Finding libraries

The main place where libraries are hosted is <a
href='https://rubygems.org/' class='remote'
target='_blank'><strong>RubyGems.org</strong></a>, a public repository
of gems that can be searched and installed onto your machine. You may
browse and search for gems using the RubyGems website, or use the `gem`
command.

Using `gem search -r`, you can search RubyGems' repository. For
instance, `gem search -r rails` will return a list of Rails-related
gems. With the `--local` (`-l`) option, you would perform a local search
through your installed gems. To install a gem, use `gem install [gem]`.
Browsing installed gems is done with `gem list`. For more information
about the `gem` command, see below or head to <a
href='http://guides.rubygems.org/' class='remote'
target='_blank'>RubyGems’ docs</a>.

There are other sources of libraries though. <a
href='https://github.com/' class='remote'
target='_blank'><strong>GitHub</strong></a> is the main Ruby-related
content repository. Most often a gem source code will be hosted on
GitHub while being published as a fully-fledged gem to RubyGems.org.

<a href='https://www.ruby-toolbox.com/' class='remote'
target='_blank'><strong>The Ruby Toolbox</strong></a> is a project that
makes it easy to explore open source Ruby projects. It has categories
for various common development tasks, collects a lot of information
about the projects like release and commit activity or dependencies and
rates projects based on their popularity on RubyGems.org and GitHub.
This makes it easy to find a gem which solves a particular problem such
as web frameworks, documentation tools and code quality libraries.

#### A few more words about RubyGems

Here is a quick review of the `gem` command for your daily use. <a
href='http://guides.rubygems.org/command-reference/' class='remote'
target='_blank'>More detailed documentation</a> is available, covering
all aspects of this packaging system.

##### Searching among available gems

The **search** command can be used to look for gems, based on a string.
Gems which names start with the specified string will be listed in
return. For instance, to search for the “html”-related gems:


```
$ gem search -r html

*** REMOTE GEMS ***

html-sample (1.0, 1.1)
```

The `--remote` / `-r` flag indicates that we want to inspect the
official RubyGems.org repository (default behaviour). With the `--local`
/ `-l` flag you would perform a local search among your installed gems.

##### Installing a gem

Once you know which gem you would like to **install**, for instance the
popular Ruby on Rails framework:


```
$ gem install rails
```

You can even install just a specific version of the library, using the
`--version` / `-v` flag:


```
$ gem install rails --version 5.0
```

##### Listing all gems

For a **list** of all locally installed gems:


```
$ gem list
```

To obtain a (very long) list of all gems available on RubyGems.org:


```
$ gem list -r
```

##### Help!

Documentation is available inside your terminal:


```
$ gem help
```

For instance, `gem help commands` is very useful as it outputs a list of
all `gem`’s commands.

##### Crafting your own gems

RubyGems.org has <a href='http://guides.rubygems.org/' class='remote'
target='_blank'>several guides</a> about this topic. You may also want
to investigate <a href='http://bundler.io/' class='remote'
target='_blank'>Bundler</a>, a generic tool which helps you manage an
application’s dependencies and may be used along RubyGems.

