require 'rdoc'
require 'pp'

rdoc = RDoc::RDoc.new
rdoc.instance_variable_set('@options', rdoc.load_options)
store = RDoc::Store.new
rdoc.store = store
rdoc.instance_variable_set(
  '@stats',
  RDoc::Stats.new(
    store,
    1,
    rdoc.instance_variable_get('@options').verbosity
  )
)

parsed = rdoc.parse_files(Dir['ruby/*.c'])
# parsed = rdoc.parse_files(Dir['ruby/lib/rexml'])
# parsed = rdoc.parse_files(Dir['ruby/lib/erb.rb'])
# parsed = rdoc.parse_files(["ruby/lib/net/http", "ruby/lib/net/http.rb"])
# cls = parsed
#   .flat_map { |context| [*context.classes, *context.modules] }
# p cls.first.classes.map(&:full_name)
# p cls.select { |c| c.full_name == 'ERB' }.map(&:comment_location).first
# p cls.select { |c| c.full_name == 'ERB' }.first.comment_location.first
# puts RDoc::Markup::ToMarkdown.new.convert(cls.comment.parse)

k = parsed.flat_map(&:modules).select { |mod| mod.full_name == 'Kernel' }
m = k.first.method_list.first
p m.methods.sort - Object.methods
pp k.first.method_list.map(&:arglists)