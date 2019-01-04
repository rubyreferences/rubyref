---
title: Installation
prev: "/"
next: "/intro/implementations.html"
---

## Installation[](#installation)



With package managers or third-party tools, you have plenty of options
to install and manage Ruby.

You may already have Ruby installed on your computer. You can check
inside a <a
href='https://en.wikipedia.org/wiki/List_of_terminal_emulators'
class='remote' target='_blank'>terminal emulator</a> by typing:


```ruby
ruby -v
```

This should output some information on the installed Ruby version.

### Choose Your Installation Method[](#choose-your-installation-method)

There are several ways to install Ruby:

* On a UNIX-like operating system, using your system's **package
  manager** is easiest. However, the packaged Ruby version may not be
  the newest one.
* **Installers** can be used to install a specific or multiple Ruby
  versions. There is also an installer for Windows.
* **Managers** help you to switch between multiple Ruby versions on your
  system.
* Finally, you can also **build Ruby from source**.

Here are available installation methods:

### Package Management Systems[](#package-management-systems)

If you cannot compile your own Ruby, and you do not want to use a
third-party tool, you can use your system's package manager to install
Ruby.

Some members of the Ruby community feel that you should avoid package
managers to install Ruby and that you should use dedicated tools
instead.

It's possible that major package managers will install older Ruby
versions instead of the latest release. To use the latest Ruby release,
check that the package name matches its version number. Or use a
dedicated <a
href='http://ruby-lang.org/en/documentation/installation/#installers'
class='remote' target='_blank'>installer</a>.

#### apt (Debian or Ubuntu)[](#apt-debian-or-ubuntu)

Debian GNU/Linux and Ubuntu use the apt package manager. You can use it
like this:


```
$ sudo apt-get install ruby-full
```

As of writing, the `ruby-full` package provides Ruby 2.3.1, which is an
old stable release, on Debian and Ubuntu.

#### yum (CentOS, Fedora, or RHEL)[](#yum-centos-fedora-or-rhel)

CentOS, Fedora, and RHEL use the yum package manager. You can use it
like this:


```
$ sudo yum install ruby
```

The installed version is typically the latest version of Ruby available
at the release time of the specific distribution version.

#### snap (Ubuntu or other linux distribution)[](#snap-ubuntu-or-other-linux-distribution)

Snap is a package manager developed by Canonical. It's available
out-of-the-box on Ubuntu, but snap also works on many Linux
distributions. You can use it like this.


```
$ sudo snap install ruby --classic
```

We have several channels per Ruby minor series. For instance, the
following commands switch to Ruby 2.3:


```
$ sudo snap switch ruby --channel=2.3/stable
$ sudo snap refresh
```

#### portage (Gentoo)[](#portage-gentoo)

Gentoo uses the portage package manager.


```
$ sudo emerge dev-lang/ruby
```

By default, this will try to install versions 1.9 and 2.0, but more
versions are available. To install a specific version, set
`RUBY_TARGETS` in your `make.conf`. See the <a
href='http://www.gentoo.org/proj/en/prog_lang/ruby/' class='remote'
target='_blank'>Gentoo Ruby Project website</a> for details.

#### pacman (Arch Linux)[](#pacman-arch-linux)

Arch Linux uses a package manager named pacman. To get Ruby, just do
this:


```
$ sudo pacman -S ruby
```

This should install the latest stable Ruby version.

#### Homebrew (macOS)[](#homebrew-macos)

Ruby versions 2.0 and above are included by default in macOS releases
since at least El Capitan (10.11) all the way through Mojave (10.14).

<a href='http://brew.sh/' class='remote' target='_blank'>Homebrew</a> is
a commonly used package manager on macOS. Installing Ruby using Homebrew
is easy:


```
$ brew install ruby
```

This should install the latest Ruby version.

#### FreeBSD[](#freebsd)

FreeBSD offers both pre-packaged and source-based methods to install
Ruby. Prebuilt packages can be installed via the pkg tool:


```
$ pkg install ruby
```

A source-based method can be used to install Ruby using the <a
href='https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/ports-using.html'
class='remote' target='_blank'>Ports Collection</a>. This is useful if
you want to customize the build configuration options.

More information about Ruby and its surrounding ecosystem on FreeBSD can
be found on the <a href='https://wiki.freebsd.org/Ruby' class='remote'
target='_blank'>FreeBSD Ruby Project website</a>.

#### Ruby on Solaris and OpenIndiana[](#ruby-on-solaris-and-openindiana)

Ruby 1.8.7 is available for Solaris 8 through Solaris 10 on <a
href='http://www.sunfreeware.com' class='remote'
target='_blank'>Sunfreeware</a> and Ruby 1.8.7 is available at <a
href='http://www.blastwave.org' class='remote'
target='_blank'>Blastwave</a>. Ruby 1.9.2p0 is also available at <a
href='http://www.sunfreeware.com' class='remote'
target='_blank'>Sunfreeware</a>, but this is outdated.

To install Ruby on <a href='http://openindiana.org/' class='remote'
target='_blank'>OpenIndiana</a>, please use the Image Packaging System
(IPS) client. This will install the Ruby binaries and RubyGems directly
from the OpenIndiana repositories. It’s easy:


```
$ pkg install runtime/ruby
```

However, the third-party tools might be a good way to obtain the latest
version of Ruby.

#### Other Distributions[](#other-distributions)

On other systems, you can search the package repository of your Linux
distribution's manager for Ruby. Alternatively, you can use a <a
href='http://ruby-lang.org/en/documentation/installation/#installers'
class='remote' target='_blank'>third-party installer</a>.

### Installers[](#installers)

If the version of Ruby provided by your system or package manager is out
of date, a newer one can be installed using a third-party installer.

Some installers allow you to install multiple versions on the same
system; associated managers can help to switch between the different
Rubies.

If you are planning to use RVM as a version manager you don't need a
separate installer, it comes with its own.

#### ruby-build[](#ruby-build)

<a href='https://github.com/rbenv/ruby-build#readme' class='remote'
target='_blank'>ruby-build</a> is a plugin for rbenv that allows you to
compile and install different versions of Ruby. ruby-build can also be
used as a standalone program without rbenv. It is available for macOS,
Linux, and other UNIX-like operating systems.

#### ruby-install[](#ruby-install)

<a href='https://github.com/postmodern/ruby-install#readme'
class='remote' target='_blank'>ruby-install</a> allows you to compile
and install different versions of Ruby into arbitrary directories.
chruby is a complimentary tool used to switch between Ruby versions.
It's available for macOS, Linux, and other UNIX-like operating systems.

#### RubyInstaller[](#rubyinstaller)

On Windows, <a href='https://rubyinstaller.org/' class='remote'
target='_blank'>RubyInstaller</a> gives you everything you need to set
up a full Ruby development environment.

Just download it, run it, and you are done!

#### RailsInstaller and Ruby Stack[](#railsinstaller-and-ruby-stack)

If you are installing Ruby in order to use Ruby on Rails, you can use
the following installers:

* <a href='http://railsinstaller.org/' class='remote'
  target='_blank'>RailsInstaller</a> uses <a
  href='https://rubyinstaller.org/' class='remote'
  target='_blank'>RubyInstaller</a> but gives you extra tools that help
  with Rails development. It supports macOS and Windows.
* <a href='http://bitnami.com/stack/ruby/installer' class='remote'
  target='_blank'>Bitnami Ruby Stack</a> provides a complete development
  environment for Rails. It supports macOS, Linux, Windows, virtual
  machines, and cloud images.

### Managers[](#managers)

Many Rubyists use Ruby managers to manage multiple Rubies. They allow
easy or even automatic switching between Ruby versions depending on the
project and other advantages but are not officially supported. You can
however find support within their respective communities.

#### chruby[](#chruby)

<a href='https://github.com/postmodern/chruby#readme' class='remote'
target='_blank'>chruby</a> allows you to switch between multiple Rubies.
It can manage Rubies installed by ruby-install or even built from
source.

#### rbenv[](#rbenv)

<a href='https://github.com/rbenv/rbenv#readme' class='remote'
target='_blank'>rbenv</a> allows you to manage multiple installations of
Ruby. While it can't install Ruby by default, its ruby-build plugin can.
Both tools are available for macOS, Linux, or other UNIX-like operating
systems.

#### RVM ("Ruby Version Manager")[](#rvm-ruby-version-manager)

<a href='http://rvm.io/' class='remote' target='_blank'>RVM</a> allows
you to install and manage multiple installations of Ruby on your system.
It can also manage different gemsets. It is available for macOS, Linux,
or other UNIX-like operating systems.

#### uru[](#uru)

<a href='https://bitbucket.org/jonforums/uru' class='remote'
target='_blank'>Uru</a> is a lightweight, multi-platform command line
tool that helps you to use multiple Rubies on macOS, Linux, or Windows
systems.

### Building from Source[](#building-from-source)

Of course, you can install Ruby from source. <a
href='http://ruby-lang.org/en/downloads/' class='remote'
target='_blank'>Download</a> and unpack a tarball, then just do this:


```
$ ./configure
$ make
$ sudo make install
```

By default, this will install Ruby into `/usr/local`. To change, pass
the `--prefix=DIR` option to the `./configure` script.

You can find more information about building from source in the <a
href='https://github.com/ruby/ruby#how-to-compile-and-install'
class='remote' target='_blank'>Ruby README file</a>.

Using the third-party tools or package managers might be a better idea,
though, because the installed Ruby won't be managed by any tools.

