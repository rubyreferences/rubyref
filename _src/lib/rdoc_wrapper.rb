require 'rdoc'

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
    when %r{lib/ostruct\.rb$}
      # Version is introduced => docs.lost: https://github.com/ruby/ruby/commit/9be3295d53b6fd9f8a3ad8157aa0655b1976d8ac
      content.sub("require_relative 'ostruct/version'\n", "")
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

class RDocExtractor
  def self.call(*pathes, with_methods: [])
    new.call(pathes, with_methods: with_methods)
  end

  def initialize
    @rdoc = RDoc::RDoc.new.tap do |rdoc|
      store = RDoc::Store.new
      rdoc.instance_variable_set('@options', RDoc::Options.new.tap { |o| o.verbosity = 0 } )
      rdoc.store = store
      rdoc.instance_variable_set('@stats', RDoc::Stats.new(store, 1, 0))
    end
  end

  def call(pathes, with_methods: [])
    @rdoc.parse_files(pathes.map(&:to_s)).flat_map(&method(:unnest))
      .to_h { |mod|
        [
          fix_name(mod.full_name),
          comments(mod, with_methods: with_methods.include?(mod.full_name))
        ]
      }
      .reject { |name, data| data['main'].then { _1.nil? || _1.strip.empty? } }
      .sort_by(&:first).to_h
  end

  private

  def unnest(context)
    [*context.classes, *context.modules].flat_map { |mod| [mod, *unnest(mod)] }
  end

  def fix_name(module_name)
    # https://github.com/ruby/rdoc/issues/741
    module_name == 'File::File::Constants' ? 'File::Constants' : module_name
  end

  def comments(mod, with_methods: false)
    if with_methods
      methods = mod.method_list.to_h { [_1.name, _1.comment.text] }
    end
    {
      main: mod.comment_location.map(&:first).compact.max_by { |c| c.text.length }&.text,
      methods: methods
    }.compact.transform_keys(&:to_s)
  end
end