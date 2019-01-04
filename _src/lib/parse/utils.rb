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

  # There is unfortunate :stopdoc: in
  # https://github.com/ruby/ruby/commit/8ea6c92eb3877bef97c289c3c2c5624366395b5d
  # Ideas of dealing with it with more grace?..
  def self.read_file(path, *args)
    OLD_READ_FILE.call(path, *args)
      .yield_self { |res|
        next res unless path.end_with?('lib/time.rb')
        res.sub("# :stopdoc:\n", "").sub("# :startdoc:\n", "")
      }
  end
end

def parse_files(*pathes)
  prepare_rdoc.parse_files(pathes)
end


# Net::* and IO::* are separate libraries, Enumerator includes Enumerator::Lazy, which is also separate concept.
WITH_SUBMODULES = %w[Net IO Enumerator]

def root_module?(mod)
  !mod.full_name.include?('::') ||
    mod.full_name.split('::')
      .yield_self { |parts| parts.count == 2 && WITH_SUBMODULES.include?(parts.first) }
end

def children(context)
  [*context.classes, *context.modules].flat_map { |mod| [mod, *children(mod)] }
end


def parse_modules(*pathes)
  parse_files(*pathes)
    .flat_map(&method(:children))
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
