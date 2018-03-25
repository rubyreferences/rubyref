# RDocTask

RDoc::Task creates the following rake tasks to generate and clean up RDoc
output:

rdoc
:   Main task for this RDoc task.

clobber_rdoc
:   Delete all the rdoc files.  This target is automatically added to the main
    clobber target.

rerdoc
:   Rebuild the rdoc files from scratch, even if they are not out of date.


Simple Example:

    require 'rdoc/task'

    RDoc::Task.new do |rdoc|
      rdoc.main = "README.rdoc"
      rdoc.rdoc_files.include("README.rdoc", "lib   /*.rb")
    end

The `rdoc` object passed to the block is an RDoc::Task object. See the
attributes list for the RDoc::Task class for available customization options.

## Specifying different task names

You may wish to give the task a different name, such as if you are generating
two sets of documentation.  For instance, if you want to have a development
set of documentation including private methods:

    require 'rdoc/task'

    RDoc::Task.new :rdoc_dev do |rdoc|
      rdoc.main = "README.doc"
      rdoc.rdoc_files.include("README.rdoc", "lib/   *.rb")
      rdoc.options << "--all"
    end

The tasks would then be named :*rdoc_dev*, :clobber_*rdoc_dev*, and
:re*rdoc_dev*.

If you wish to have completely different task names, then pass a Hash as first
argument. With the `:rdoc`, `:clobber_rdoc` and `:rerdoc` options, you can
customize the task names to your liking.

For example:

    require 'rdoc/task'

    RDoc::Task.new(:rdoc => "rdoc", :clobber_rdoc => "rdoc:clean",
                   :rerdoc => "rdoc:force")

This will create the tasks `:rdoc`, `:rdoc:clean` and `:rdoc:force`.

[RDocTask Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/rdoc/rdoc/RDocTask.html)
