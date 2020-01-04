# Find

The `Find` module supports the top-down traversal of a set of file paths.

For example, to total the size of all files under your home directory,
ignoring anything in a "dot" directory (e.g. $HOME/.ssh):

    require 'find'

    total_size = 0

    Find.find(ENV["HOME"]) do |path|
      if FileTest.directory?(path)
        if File.basename(path).start_with?('.')
          Find.prune       # Don't look any further into this directory.
        else
          next
        end
      else
        total_size += FileTest.size(path)
      end
    end

[Find Reference](https://ruby-doc.org/stdlib-2.7.0/libdoc/find/rdoc/Find.html)
