# Generic

def libname(f)
  base = f.sub(rubypath('lib/'), '')
  if base.start_with?('/net/')
    "net/" + File.basename(f, '.rb')
  else
    File.basename(f, '.rb')
  end
end

def rubypath(path)
  File.expand_path(File.join('../../ruby', path), __dir__)
end

# Parsing ==========================================================================================

def prepare_rdoc
  RDoc::RDoc.new.tap do |rdoc|
    store = RDoc::Store.new
    rdoc.instance_variable_set('@options', RDoc::Options.new.tap { |o| o.verbosity = 0 } )
    rdoc.store = store
    rdoc.instance_variable_set('@stats', RDoc::Stats.new(store, 1, 0))
  end
end

module RDoc::Encoding
  OLD_READ_FILE = method(:read_file)

  def self.read_file(path, *args)
    OLD_READ_FILE.call(path, *args)
      .then { |res| fix_source(path, res) }
  end

  def self.fix_source(path, content)
    case path
    when %r{lib/time\.rb$}
      # There is unfortunate :stopdoc: in
      # https://github.com/ruby/ruby/commit/8ea6c92eb3877bef97c289c3c2c5624366395b5d
      # Ideas of dealing with it with more grace?..
      content.sub("# :stopdoc:\n", "").sub("# :startdoc:\n", "")
    when %r{/file\.c$}
      # Weird bug in Rdoc, it parses File::Constants as File::File::Constants...
      # ...and this code doesn't help. :shrug:
      # Fixed later.
      #
      # content.sub('Document-module: File::Constants', 'Document-class: File::Constants')
      content
    else
      content
    end
  end
end

def parse_files(*pathes)
  prepare_rdoc.parse_files(pathes)
end


# Net::* and IO::* are separate libraries
# Enumerator includes Enumerator::Lazy, which is also separate concept
# File include Constants and Stat
WITH_SUBMODULES = %w[Net IO Enumerator File]

# We want them anyways!
ROOT_EXCEPTIONS = %w[]

def root_module?(mod)
  mod.full_name.then { |name|
    !name.include?('::') ||
      ROOT_EXCEPTIONS.include?(name) ||
      name.split('::').then { |parts| parts.count == 2 && WITH_SUBMODULES.include?(parts.first) }
  }
end

def children(context)
  [*context.classes, *context.modules].flat_map { |mod| [mod, *children(mod)] }
end

def fix_name(mod)
  # Bug in RDoc, it SHOULD be File::Constants
  if mod.full_name == 'File::File::Constants'
    def mod.full_name
      'File::Constants'
    end
  end
end

def parse_modules(*pathes)
  parse_files(*pathes)
    .flat_map(&method(:children))
    .each(&method(:fix_name))
    .select(&method(:root_module?))
    .group_by(&:full_name).map { |_, g| g.first }
end

# Generating =======================================================================================

def write(target, text, source: nil)
  target = File.join(OUT, target) + '.md'
  puts "#{source} => #{target}"
  FileUtils.mkdir_p File.dirname(target)
  File.write target, text
end

def write_mod(path, mod, reference: '#TODO', source: nil)
  comment = mod.comment_location.map(&:first).compact.sort_by { |c| c.text.length }.last
  return if comment.nil? || comment.text.empty?

  write(
    "#{path}/#{mod.full_name.gsub('::', '--')}",
    "# #{mod.full_name}\n\n" +
    MARKDOWN.convert(comment.parse) +
    "\n[#{mod.full_name} Reference](#{reference}/#{mod.full_name.gsub('::', '/')}.html)\n",
    source: source
  )
end
