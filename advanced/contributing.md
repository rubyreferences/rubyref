---
title: Contributing To Ruby
prev: "/advanced/signals.html"
next: "/appendix-a.html"
---

## Contributing to Ruby[](#contributing-to-ruby)

Ruby has a vast and friendly community with hundreds of people
contributing to a thriving open-source ecosystem. This guide is designed
to cover ways for participating in the development of CRuby.

There are plenty of ways for you to help even if you're not ready to
write code or documentation. You can help by reporting issues, testing
patches, and trying out beta releases with your applications.

### How To Report[](#how-to-report)

If you've encountered a bug in Ruby please report it to the redmine
issue tracker available at <a href='https://bugs.ruby-lang.org/'
class='remote' target='_blank'>bugs.ruby-lang.org</a>. Do not report
security vulnerabilities here, there is a separate channel for them.

There are a few simple steps you should follow in order to receive
feedback on your ticket.

* If you haven't already, <a
  href='https://bugs.ruby-lang.org/account/register' class='remote'
  target='_blank'>sign up for an account</a> on the bug tracker.

* Try the latest version.
  
  If you aren't already using the latest version, try installing a newer
  stable release. See <a href='https://www.ruby-lang.org/en/downloads/'
  class='remote' target='_blank'>Downloading Ruby</a>.

* Look to see if anyone already reported your issue, try <a
  href='https://bugs.ruby-lang.org/projects/ruby-trunk/issues'
  class='remote' target='_blank'>searching on redmine</a> for your
  problem.

* If you can't find a ticket addressing your issue, <a
  href='https://bugs.ruby-lang.org/projects/ruby-trunk/issues/new'
  class='remote' target='_blank'>create a new one</a>.

* Choose the target version, usually current. Bugs will be first fixed
  in the current release and then backported.

* Fill in the Ruby version you're using when experiencing this issue
  (`ruby
  -v`).

* Attach any logs or reproducible programs to provide additional
  information. Reproducible scripts should be as small as possible.

* Briefly describe your problem. A 2-3 sentence description will help
  give a quick response.

* Pick a category, such as core for common problems, or lib for a
  standard library.

* Check the <a
  href='https://bugs.ruby-lang.org/projects/ruby/wiki/Maintainers'
  class='remote' target='_blank'>Maintainers list</a> and assign the
  ticket if there is an active maintainer for the library or feature.

* If the ticket doesn't have any replies after 10 days, you can send a
  reminder.

* Please reply to feedback requests. If a bug report doesn't get any
  feedback, it'll eventually get rejected.

#### Reporting to downstream distributions[](#reporting-to-downstream-distributions)

You can report downstream issues for the following distributions via
their bug tracker:

* <a
  href='https://bugs.debian.org/cgi-bin/pkgreport.cgi?src=ruby-defaults'
  class='remote' target='_blank'>debian</a>
* <a href='http://www.freebsd.org/cgi/query-pr-summary.cgi?text=ruby'
  class='remote' target='_blank'>freebsd</a>
* <a
  href='https://bugzilla.redhat.com/buglist.cgi?bug_status=NEW&bug_status
  =ASSIGNED&bug_status=REOPENED&bug_status=MODIFIED' class='remote'
  target='_blank'>redhat</a>

* <a
  href='https://trac.macports.org/query?status=assigned&status=new&stat
  us=reopened&port=~ruby' class='remote' target='_blank'>macports</a>

* etc (add your distribution bug tracker here)

#### Platform Maintainers[](#platform-maintainers)

For platform specific bugs in Ruby, you can assign your ticket to the
current maintainer for a specific platform.

The current active platform maintainers are as follows:

* mswin64 (Microsoft Windows): NAKAMURA Usaku (usa)
* mingw32 (Minimalist GNU for Windows): Nobuyoshi Nakada (nobu)
* AIX: Yutaka Kanemoto (kanemoto)
* FreeBSD: Akinori MUSHA (knu)
* Solaris: Naohisa Goto (ngoto)
* RHEL, CentOS: KOSAKI Motohiro (kosaki)
* macOS: Kenta Murata (mrkn)
* OpenBSD: Jeremy Evans (jeremyevans0)
* cygwin, bcc32, djgpp, wince, ...\: none. (Maintainer WANTED)

### Reporting Security Issues[](#reporting-security-issues)

Security vulnerabilities receive special treatment since they may
negatively affect many users. There is a private mailing list that all
security issues should be reported to and will be handled discretely.
Email the mailto:security@ruby-lang.org list and the problem will be
published after fixes have been released. You can also encrypt the issue
using <a href='https://www.ruby-lang.org/security.asc' class='remote'
target='_blank'>the PGP public key</a> for the list.

### Reporting Other Issues[](#reporting-other-issues)

If you're having an issue with the website, or maybe the mailing list,
you can contact the webmaster to help resolve the problem.

The current webmaster is:

* Hiroshi SHIBATA (hsbt)

You can also report issues with the ruby-lang.org website on the issue
tracker:

* <a href='https://github.com/ruby/www.ruby-lang.org/issues'
  class='remote' target='_blank'>issue tracker</a>

### Resolve Existing Issues[](#resolve-existing-issues)

As a next step beyond reporting issues you can help the core team
resolve existing issues. If you check the Everyone's Issues list in
GitHub Issues, you will find a lot of issues already requiring
attention. What can you do for these? Quite a bit, actually:

When a bug report goes for a while without any feedback, it goes to the
bug graveyard which is unfortunate. If you check the <a
href='https://bugs.ruby-lang.org/projects/ruby-trunk/issues'
class='remote' target='_blank'>issues list</a> you will find lots of
delinquent bugs that require attention.

You can help by verifying the existing tickets, try to reproduce the
reported issue on your own and comment if you still experience the bug.
Some issues lack attention because of too much ambiguity, to help you
can narrow down the problem and provide more specific details or
instructions to reproduce the bug. You might also try contributing a
failing test in the form of a patch, which we will cover later in this
guide.

It may also help to try out patches other contributors have submitted to
redmine, if gone without notice. In this case the `patch` command is
your friend, see `man patch` for more information. Basically this would
go something like this:


```ruby
cd path/to/ruby
patch -p0 < path/to/patch
```

You will then be prompted to apply the patch with the associated files.
After building ruby again, you should try to run the tests and verify if
the change actually worked or fixed the bug. It's important to provide
valuable feedback on the patch that can help reach the overall goal, try
to answer some of these questions:

* What do you like about this change?
* What would you do differently?
* Are there any other edge cases not tested?
* Is there any documentation that would be affected by this change?

If you can answer some or all of these questions, you're on the right
track. If your comment simply says "+1", then odds are that other
reviewers aren't going to take it too seriously. Show that you took the
time to review the patch.

### How To Request Features[](#how-to-request-features)

If there's a new feature that you want to see added to Ruby, you will
need to write a convincing proposal and patch to implement the feature.

For new features in CRuby, use the <a
href='https://bugs.ruby-lang.org/projects/ruby-trunk/issues?set_filter=1&tr
acker_id=2' class='remote' target='_blank'>'Feature' tracker</a> on
ruby-master. For non-CRuby dependent features, features that would apply
to alternate Ruby implementations such as JRuby and Rubinius, use the <a
href='https://bugs.ruby-lang.org/projects/common-ruby' class='remote'
target='_blank'>CommonRuby tracker</a>.

When writing a proposal be sure to check for previous discussions on the
topic and have a solid use case. You will need to be persuasive and
convince Matz on your new feature. You should also consider the
potential compatibility issues that this new feature might raise.

Consider making your feature into a gem, and if there are enough people
who benefit from your feature it could help persuade ruby-core. Although
feature requests can seem like an alluring way to contribute to Ruby,
often these discussions can lead nowhere and exhaust time and energy
that could be better spent fixing bugs. Choose your battles.

A good template for a feature proposal should look something like this:

* Abstract: Summary of your feature
* Background: Describe current behavior and why it is problem. Related
  work, such as solutions in other language helps us to understand the
  problem.

* Proposal: Describe your proposal in details
* Details: If it has complicated feature, describe it
* Usecase: How would your feature be used? Who will benefit from it?
* Discussion: Discuss about this proposal. A list of pros and cons will
  help start discussion.

* Limitation: Limitation of your proposal
* Another alternative proposal: If there are alternative proposals, show
  them.
* See also: Links to the other related resources

#### Slideshow[](#slideshow)

At the Ruby Developer Meeting in Japan, committers discuss Feature
Proposals together in Tokyo. We will judge proposals and then accept,
reject, or give feedback for them. If you have a stalled proposal,
making a slide to submit is good way to get feedback.

Slides should be:

* One-page slide
* Include a corresponding ticket number
* MUST include a figure and/or short example code
* SHOULD have less sentence in natural language (try to write less than
  140 characters)

* It is RECOMMENDED to itemize: motivation/use case, proposal,
  pros/cons, corner case

* PDF or Image (Web browsers can show it)

Please note:

* Even if the proposal is generally acceptable, it won't be accepted
  without writing corner cases in the ticket

* Slide's example: DevelopersMeeting20130727Japan

### Backport Requests[](#backport-requests)

When a new version of Ruby is released, it starts at patch level 0 (p0),
and bugs will be fixed first on the master branch. If it's determined
that a bug exists in a previous version of Ruby that is still in the bug
fix stage of maintenance, then a patch will be backported. After the
maintenance stage of a particular Ruby version ends, it goes into
"security fix only" mode which means only security related
vulnerabilities will be backported. Versions in End-of-life (EOL) will
not receive any updates and it is recommended you upgrade as soon as
possible.

If a major security issue is found or after a certain amount of time
since the last patch level release, a new patch-level release will be
made.

When submitting a backport request please confirm the bug has been fixed
in newer versions and exists in maintenance mode versions. There is a
backport tracker for each major version still in maintenance where you
can request a particular revision merged in the affected version of
Ruby.

Each major version of Ruby has a release manager that should be assigned
to handle backport requests. You can find the list of release managers
on the <a
href='https://bugs.ruby-lang.org/projects/ruby/wiki/ReleaseEngineering'
class='remote' target='_blank'>wiki</a>.

#### Branches[](#branches)

Status and maintainers of branches are listed on the <a
href='https://bugs.ruby-lang.org/projects/ruby/wiki/ReleaseEngineering'
class='remote' target='_blank'>wiki</a>.

### Running tests[](#running-tests)

In order to help resolve existing issues and contributing patches to
Ruby you need to be able to run the test suite.

CRuby uses git for source control, the <a href='https://git-scm.com/'
class='remote' target='_blank'>git homepage</a> has installation
instructions with links to documentation for learning more about git.
There is a mirror of the repository on <a
href='https://github.com/ruby/ruby' class='remote'
target='_blank'>github</a>. For other resources see the <a
href='https://www.ruby-lang.org/en/community/ruby-core/' class='remote'
target='_blank'>ruby-core documentation on ruby-lang.org</a>.

Install the prerequisite dependencies for building the CRuby interpreter
to run tests.

* C compiler
* autoconf - 2.67 or later, preferably 2.69.
* bison - 2.0 or later, preferably 3.4.
* gperf - 3.0.3 or later, preferably 3.1.
* ruby - Ruby itself is prerequisite in order to build Ruby from source.
  It can be 1.8.

You should also have access to development headers for the following
libraries, but these are not required:

* NDBM/QDBM
* GDBM
* OpenSSL/LibreSSL
* readline/editline(libedit)
* zlib
* libffi
* libyaml
* libexecinfo (FreeBSD)

Now let's build CRuby:

* Checkout the CRuby source code:
  
  
  ```
  git clone https://github.com/ruby/ruby.git ruby-master
  ```

* Generate the configuration files and build:
  
  
  ```
  cd ruby-master
  autoconf
  mkdir build && cd build # its good practice to build outside of source dir
  mkdir ~/.rubies # we will install to .rubies/ruby-master in our home dir
  ../configure --prefix="${HOME}/.rubies/ruby-master"
  make up && make install
  ```

After adding Ruby to your PATH, you should be ready to run the test
suite:


```ruby
make test
```

You can also use `test-all` to run all of the tests with the RUNRUBY
interpreter just built. Use TESTS or RUNRUBYOPT to pass parameters, such
as:


```
make test-all TESTS=-v
```

This is also how you can run a specific test from our build dir:


```
make test-all TESTS=drb/test_drb.rb
```

You can run `test` and `test-all` at once by `check` .


```ruby
make check
```

For older versions of Ruby you will need to run the build setup again
after checking out the associated branch in git, for example if you
wanted to checkout 1.9.3:


```
git clone https://github.com/ruby/ruby.git --branch ruby_1_9_3
```

Once you checked out the source code, you can update the local copy by:


```ruby
make up
```

Or, update, build, install and check, by just:


```ruby
make love
```

### Contributing Documentation[](#contributing-documentation)

If you're interested in contributing documentation directly to CRuby
there is some information available at <a
href='https://github.com/ruby/ruby#contributing' class='remote'
target='_blank'>Contributing</a>.

There is also the <a href='https://github.com/rurema/doctree/wiki'
class='remote' target='_blank'>Ruby Reference Manual</a> in Japanese.

### Contributing A Patch[](#contributing-a-patch)

#### Deciding what to patch[](#deciding-what-to-patch)

Before you submit a patch, there are a few things you should know:

* Pay attention to the maintenance policy for stable and maintained
  versions of Ruby.

* Released versions in security mode will not merge feature changes.
* Search for previous discussions on ruby-core to verify the maintenance
  policy

* Patches must be distributed under Ruby's license.
* This license may change in the future, you must join the discussion if
  you don't agree to the change

To improve the chance your patch will be accepted please follow these
simple rules:

* Bug fixes should be committed on master first
* Format of the patch file must be a unified diff (ie: diff -pu, svn
  diff, or git diff)

* Don't introduce cosmetic changes
* Follow the original coding style of the code
* Don't mix different changes in one commit

First thing you should do is check out the code if you haven't already:


```
git clone https://github.com/ruby/ruby.git ruby-master
```

Now create a dedicated branch:


```
cd ruby-master
git checkout -b my_new_branch
```

The name of your branch doesn't really matter because it will only exist
on your local computer and won't be part of the official Ruby
repository. It will be used to create patches based on the differences
between your branch and master, or edge Ruby.

#### Coding style[](#coding-style)

Here are some general rules to follow when writing Ruby and C code for
CRuby:

* Indent 4 spaces for C without tabs (old codes might use tabs for
  eight-space indentation, but newer codes recommend to use spaces only)

* Indent 2 space tabs for Ruby
* Do not use TABs in ruby codes
* ANSI C style for 1.9+ for function declarations
* Follow C90 (not C99) Standard
* PascalStyle for class/module names.
* UNDERSCORE\_SEPARATED\_UPPER\_CASE for other constants.
* Capitalize words.
* ABBRs should be all upper case.
* Do as others do

#### Commit messages[](#commit-messages)

When you're ready to commit:


```ruby
git commit path/to/files
```

This will open your editor in which you write your commit message. Use
the following style for commit messages:

* Use a succinct subject line.
* Include reasoning behind the change in the commit message, focusing on
  why the change is being made.

* Refer to redmine issue (such as Fixes \[Bug #1234\] or Implements
  \[Feature #3456\]), or discussion on the mailing list (such as
  \[ruby-core:12345\]).

* For GitHub issues, use \[GH-#\] (such as \[Fixes GH-234\]).
* Follow the style used by other committers.

#### Contributing your code[](#contributing-your-code)

Now that you've got some code you want to contribute, let's get set up
to generate a patch. Start by forking the github mirror, check the <a
href='https://help.github.com/articles/fork-a-repo' class='remote'
target='_blank'>github docs on forking</a> if you get stuck here. You
will only need a github account if you intend to host your repository on
github.

Next copy the writable url for your fork and add it as a git remote,
replace "my\_username" with your github account name:


```ruby
git remote add my_fork git@github.com:my_username/ruby.git
# Now we can push our branch to our fork
git push my_fork my_new_branch
```

In order to generate a patch that you can upload to the bug tracker, we
can use the github interface to review our changes just visit
https://github.com/my_username/ruby/compare/master...my_new_branch

Next, you can simply add '.patch' to the end of this URL and it will
generate the patch for you, save the file to your computer and upload it
to the bug tracker. Alternatively you can submit a pull request, but for
the best chances to receive feedback add it is recommended you add it to
redmine.

Since git is a distributed system, you are welcome to host your git
repository on any <a
href='https://git.wiki.kernel.org/index.php/GitHosting' class='remote'
target='_blank'>publicly accessible hosting site</a>, including <a
href='https://www.kernel.org/pub/software/scm/git/docs/user-manual.html#public-
repositories' class='remote' target='_blank'>hosting your own</a> You
may use the <a href='https://git-scm.com/docs/git-format-patch'
class='remote' target='_blank'>'git format-patch'</a> command to
generate patch files to upload to redmine. You may also use the <a
href='https://git-scm.com/docs/git-request-pull' class='remote'
target='_blank'>'git request-pull'</a> command for formatting pull
request messages to redmine.

#### Updating the official repository[](#updating-the-official-repository)

If you are a committer, you can push changes directly into the official
repository:


```
git push origin your-branch-name:master
```

However, it is likely will have become outdated, and you will have to
update it. In that case, run:


```ruby
git fetch origin
git rebase remotes/origin/master
```

and then try pushing your changes again.







