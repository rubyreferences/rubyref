# Directory Structure of Ruby Program

Ruby does not enforce any particular directory structure. Loading code from different files is performed by [require](ref:Kernel#require), [require_relative](ref:Kernel#require_relative) or [load](ref:Kernel#load). The filesystem structure is not related to the module structure, because all constants (including classes and modules) from loaded files are imported into the global namespace.

Ruby looks for the files passed to `require` in the directories enumerated in `$LOAD_PATH` constant. If the file is not found, [LoadError](builtin/exception/exception-classes.md#loaderror) exception is raised and can be caught. This allows implementation of "optional library" pattern:

    begin
      require 'somelibrary'
    rescue LoadError
      warn "You need to install somelibrary to access <some functionality>"
    end

There are soft community conventions, suggesting one class or module per file and correspondence
between filesystem and module structure (e.g. `require 'library_name/namespace/class_name'` should load
`LibraryName::Namespace::ClassName`), though it is neither required nor enforced by default.

See also:

* [Standard Library](stdlib.md)
* [Third-party Libraries](developing/libraries.md)
* [Code Style and Linting](developing/code-style.md)
