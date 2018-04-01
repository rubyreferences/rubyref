---
title: Installation
prev: "/about-this-book.html"
next: "/installation/implementations.html"
---

# Installation



You can use several tools to install Ruby. This page describes how to
use major package management systems and third-party tools for managing
and installing Ruby and how to build Ruby from source.

## Choose Your Installation Method

There are several ways to install Ruby:

* When you are on a UNIX-like operating system, using your system's
  **package manager** is the easiest way of getting started. However,
  the packaged Ruby version usually is not the newest one.
* **Installers** can be used to install a specific or multiple Ruby
  versions. There is also an installer for Windows.
* **Managers** help you to switch between multiple Ruby installations on
  your system.
* And finally, you can also **build Ruby from source**.

The following overview lists available installation methods for
different needs and platforms.

## Package Management Systems

If you cannot compile your own Ruby, and you do not want to use a
third-party tool, you can use your system's package manager to install
Ruby.

Certain members in the Ruby community feel very strongly that you should
never use a package manager to install Ruby and that you should use
tools instead. While the full list of pros and cons is outside of the
scope of this page, the most basic reason is that most package managers
have older versions of Ruby in their official repositories. If you would
like to use the newest Ruby, make sure you use the correct package name,
or use the tools described further below instead.

### apt (Debian or Ubuntu)

Debian GNU/Linux and Ubuntu use the apt package manager. You can use it
like this:


```
$ sudo apt-get install ruby-full
```

As of writing, the `ruby-full` package provides Ruby 2.3.1, which is an
old stable release, on Debian and Ubuntu.

### yum (CentOS, Fedora, or RHEL)

CentOS, Fedora, and RHEL use the yum package manager. You can use it
like this:


```
$ sudo yum install ruby
```

The installed version is typically the latest version of Ruby available
at the release time of the specific distribution version.

### portage (Gentoo)

Gentoo uses the portage package manager.


```
$ sudo emerge dev-lang/ruby
```

By default, this will try to install versions 1.9 and 2.0, but more
versions are available. To install a specific version, set
`RUBY_TARGETS` in your `make.conf`. See the [Gentoo Ruby Project
website](http://www.gentoo.org/proj/en/prog_lang/ruby/) for details.

### pacman (Arch Linux)

Arch Linux uses a package manager named pacman. To get Ruby, just do
this:


```
$ sudo pacman -S ruby
```

This should install the latest stable Ruby version.

### Homebrew (OS X)

On macOS (High) Sierra and OS X El Capitan, Ruby 2.0 is included.

Many people on OS X use [Homebrew](http://brew.sh/) as a package
manager. It is really easy to get a newer version of Ruby using
Homebrew:


```
$ brew install ruby
```

This should install the latest Ruby version.

### FreeBSD

FreeBSD offers both pre-packaged and source-based methods to install
Ruby. Prebuilt packages can be installed via the pkg tool:


```
$ pkg install ruby
```

A source-based method can be used to install Ruby using the [Ports
Collection](https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/ports-using.html).
This is useful if you want to customize the build configuration options.

More information about Ruby and its surrounding ecosystem on FreeBSD can
be found on the [FreeBSD Ruby Project
website](https://wiki.freebsd.org/Ruby).

### Ruby on Solaris and OpenIndiana

Ruby 1.8.7 is available for Solaris 8 through Solaris 10 on
[Sunfreeware](http://www.sunfreeware.com) and Ruby 1.8.7 is available at
[Blastwave](http://www.blastwave.org). Ruby 1.9.2p0 is also available at
[Sunfreeware](http://www.sunfreeware.com), but this is outdated.

To install Ruby on [OpenIndiana](http://openindiana.org/), please use
the Image Packaging System (IPS) client. This will install the Ruby
binaries and RubyGems directly from the OpenIndiana repositories. It’s
easy:


```
$ pkg install runtime/ruby
```

However, the third-party tools might be a good way to obtain the latest
version of Ruby.

### Other Distributions

On other systems, you can search the package repository of your Linux
distribution's manager for Ruby, or the third-party tools might be the
right choice for you.

## Installers

If the version of Ruby provided by your system or package manager is out
of date, a newer one can be installed using a third-party installer.
Some of them also allow you to install multiple versions on the same
system; associated managers can help to switch between the different
Rubies. If you are planning to use [RVM](#rvm) as a version manager you
do not need a separate installer, it comes with its own.

### ruby-build

[ruby-build](https://github.com/rbenv/ruby-build#readme) is a plugin for
[rbenv](#rbenv) that allows you to compile and install different
versions of Ruby into arbitrary directories. ruby-build can also be used
as a standalone program without rbenv. It is available for OS X, Linux,
and other UNIX-like operating systems.

### ruby-install

[ruby-install](https://github.com/postmodern/ruby-install#readme) allows
you to compile and install different versions of Ruby into arbitrary
directories. There is also a sibling, [chruby](#chruby), which handles
switching between Ruby versions. It is available for OS X, Linux, and
other UNIX-like operating systems.

### RubyInstaller

If you are on Windows, there is a great project to help you install
Ruby: [RubyInstaller](https://rubyinstaller.org/). It gives you
everything you need to set up a full Ruby development environment on
Windows.

Just download it, run it, and you are done!

### RailsInstaller and Ruby Stack

If you are installing Ruby in order to use Ruby on Rails, you can use
the following installers:

* [RailsInstaller](http://railsinstaller.org/), which uses RubyInstaller
  but gives you extra tools that help with Rails development. It
  supports OS X and Windows.
* [Bitnami Ruby Stack](http://bitnami.com/stack/ruby/installer), which
  provides a complete development environment for Rails. It supports OS
  X, Linux, Windows, virtual machines, and cloud images.

## Managers

Many Rubyists use Ruby managers to manage multiple Rubies. They confer
various advantages but are not officially supported. Their respective
communities are very helpful, however.

### chruby

[chruby](https://github.com/postmodern/chruby#readme) allows you to
switch between multiple Rubies. chruby can manage Rubies installed by
[ruby-install](#ruby-install) or even built from source.

### rbenv

[rbenv](https://github.com/rbenv/rbenv#readme) allows you to manage
multiple installations of Ruby. It does not support installing Ruby, but
there is a popular plugin named [ruby-build](#ruby-build) to install
Ruby. Both tools are available for OS X, Linux, or other UNIX-like
operating systems.

### RVM ("Ruby Version Manager")

[RVM](http://rvm.io/) allows you to install and manage multiple
installations of Ruby on your system. It can also manage different
gemsets. It is available for OS X, Linux, or other UNIX-like operating
systems.

### uru

[Uru](https://bitbucket.org/jonforums/uru) is a lightweight,
multi-platform command line tool that helps you to use multiple Rubies
on OS X, Linux, or Windows systems.

## Building from Source

Of course, you can install Ruby from source. [Download](/en/downloads/)
and unpack a tarball, then just do this:


```
$ ./configure
$ make
$ sudo make install
```

By default, this will install Ruby into `/usr/local`. To change, pass
the `--prefix=DIR` option to the `./configure` script.

Using the third-party tools or package managers might be a better idea,
though, because the installed Ruby won't be managed by any tools.

