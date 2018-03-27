# File Structure of Ruby Program

Ruby does not enforces any particular file structure. Loading of code
from different files is performed by [require](ref:Kernel#require),
[require\_relative](ref:Kernel#require_relative) or
[load](ref:Kernel#require_relative). Filesystem structure is not related
to modules structure, because all constants from loaded files are
imported into global namespaces.

There are soft community conventions, suggesting one class or module per
file and correspondence between filesystem and module structure (e.g.
`require 'library_name/namespace/file'` should load
`LibraryName::Namespace::Module`), though it is neither required nor
enforced by default.

See also:

* \[Standard Library\]
* \[Third-party Libraries\]
* \[Code Style and Linting\]

