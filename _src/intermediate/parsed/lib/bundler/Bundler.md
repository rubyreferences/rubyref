# Bundler

Some versions of the Bundler 1.1 RC series introduced corrupted lockfiles.
There were two major problems:

*   multiple copies of the same GIT section appeared in the lockfile
*   when this happened, those sections got multiple copies of gems in those
    sections.


As a result, Bundler 1.1 contains code that fixes the earlier corruption. We
will remove this fix-up code in Bundler 1.2.

[Bundler Reference](https://ruby-doc.org/stdlib-2.6/libdoc/bundler/rdoc/Bundler.html)
