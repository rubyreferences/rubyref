# FileUtils

# fileutils.rb

Copyright (c) 2000-2007 Minero Aoki

This program is free software. You can distribute/modify this program under
the same terms of ruby.

## module FileUtils

Namespace for several file utility methods for copying, moving, removing, etc.

### Module Functions

    require 'fileutils'

    FileUtils.cd(dir, **options)
    FileUtils.cd(dir, **options) {|dir| block }
    FileUtils.pwd()
    FileUtils.mkdir(dir, **options)
    FileUtils.mkdir(list, **options)
    FileUtils.mkdir_p(dir, **options)
    FileUtils.mkdir_p(list, **options)
    FileUtils.rmdir(dir, **options)
    FileUtils.rmdir(list, **options)
    FileUtils.ln(target, link, **options)
    FileUtils.ln(targets, dir, **options)
    FileUtils.ln_s(target, link, **options)
    FileUtils.ln_s(targets, dir, **options)
    FileUtils.ln_sf(target, link, **options)
    FileUtils.cp(src, dest, **options)
    FileUtils.cp(list, dir, **options)
    FileUtils.cp_r(src, dest, **options)
    FileUtils.cp_r(list, dir, **options)
    FileUtils.mv(src, dest, **options)
    FileUtils.mv(list, dir, **options)
    FileUtils.rm(list, **options)
    FileUtils.rm_r(list, **options)
    FileUtils.rm_rf(list, **options)
    FileUtils.install(src, dest, **options)
    FileUtils.chmod(mode, list, **options)
    FileUtils.chmod_R(mode, list, **options)
    FileUtils.chown(user, group, list, **options)
    FileUtils.chown_R(user, group, list, **options)
    FileUtils.touch(list, **options)

Possible `options` are:

* `:force`: forced operation (rewrite files if exist, remove directories if not empty,
    etc.);

* `:verbose`: print command to be run, in bash syntax, before performing it;
* `:preserve`: preserve object's group, user and modification time on copying;
* `:noop`: no changes are made (usable in combination with `:verbose` which will
    print the command to run)


Each method documents the options that it honours. See also ::commands,
::options and ::options_of methods to introspect which command have which
options.

All methods that have the concept of a "source" file or directory can take
either one file or a list of files in that argument.  See the method
documentation for examples.

There are some `low level` methods, which do not accept keyword arguments:

    FileUtils.copy_entry(src, dest, preserve = false, dereference_root = false, remove_destination = false)
    FileUtils.copy_file(src, dest, preserve = false, dereference = true)
    FileUtils.copy_stream(srcstream, deststream)
    FileUtils.remove_entry(path, force = false)
    FileUtils.remove_entry_secure(path, force = false)
    FileUtils.remove_file(path, force = false)
    FileUtils.compare_file(path_a, path_b)
    FileUtils.compare_stream(stream_a, stream_b)
    FileUtils.uptodate?(file, cmp_list)

## module FileUtils::Verbose

This module has all methods of FileUtils module, but it outputs messages
before acting.  This equates to passing the `:verbose` flag to methods in
FileUtils.

## module FileUtils::NoWrite

This module has all methods of FileUtils module, but never changes
files/directories.  This equates to passing the `:noop` flag to methods in
FileUtils.

## module FileUtils::DryRun

This module has all methods of FileUtils module, but never changes
files/directories.  This equates to passing the `:noop` and `:verbose` flags
to methods in FileUtils.

[FileUtils Reference](https://ruby-doc.org/stdlib-2.7.0/libdoc/fileutils/rdoc/FileUtils.html)