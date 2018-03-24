#!/usr/bin/env ruby

require 'rdoc'
require 'fileutils'
require 'pp'
require 'dry/inflector'

INTERM = "intermediate/parsed"

MARKDOWN = RDoc::Markup::ToMarkdown.new
INFLECTOR = Dry::Inflector.new

# TODO: currently rendered Ruby version
CORE_DOCS = 'http://ruby-doc.org/core-2.5.0'
LIB_DOCS = 'https://ruby-doc.org/stdlib-2.5.0/libdoc/%s/rdoc'

def prepare_rdoc
  RDoc::RDoc.new.tap do |rdoc|
    store = RDoc::Store.new
    rdoc.instance_variable_set('@options', RDoc::Options.new.tap { |o| o.verbosity = 0 } )
    rdoc.store = store
    rdoc.instance_variable_set('@stats', RDoc::Stats.new(store, 1, 0))
  end
end

def parse_file(path)
  prepare_rdoc.parse_file(path)
end

def parse_files(*pathes)
  prepare_rdoc.parse_files(pathes)
end

def write(target, text, source: nil)
  target = File.join(INTERM, target) + '.md'
  puts "#{source} => #{target}"
  FileUtils.mkdir_p File.dirname(target)
  File.write target, text
end

def write_mod(path, mod, reference: '#TODO', source: nil)
  comment = mod.comment_location.map(&:first).compact.sort_by { |c| c.text.length }.last
  return if comment.nil? || comment.text.empty?

  write(
    "#{path}/#{mod.full_name.sub('::', '--')}",
    "# #{mod.full_name}\n\n" +
    MARKDOWN.convert(comment.parse) +
    "\n[#{mod.full_name} Reference](#{reference}/#{mod.full_name}.html)\n",
    source: source
  )
end

# Docs
Dir['ruby/doc/{,**/}*.rdoc'].grep_v(/\.ja\./).sort.each do |source|
  write source.sub('ruby/', '').sub('.rdoc', ''),
    MARKDOWN.convert(File.read(source)),
    source: source
end

def modules_with_comments(contexts)
  contexts
    .flat_map { |context| [*context.classes, *context.modules] }
    .group_by(&:full_name).map { |n, g| g.first }
    .map { |mod|
      [
        mod.full_name,
        mod.comment_location.map(&:first).compact.sort_by { |c| c.text.length }.last
      ]
    }
    .reject { |name, cm| cm.nil? || cm.text.empty? }
    .to_h
end

def parse_modules(*pathes)
  parse_files(*pathes)
    .flat_map { |context| [*context.classes, *context.modules] }
    .group_by(&:full_name).map { |n, g| g.first }
end


# Core language:
Dir['ruby/{,**/}*.c'].grep_v(%r{/(ext|missing)/}).
  tap do |pathes|
    parse_modules(*pathes).each { |mod| write_mod('core',  mod, reference: CORE_DOCS) }
  end

def libname(f)
  base = f.sub('ruby/lib/', '')
  if base.start_with?('net/')
    "net/" + File.basename(f, '.rb')
  else
    File.basename(f, '.rb')
  end
end

# Standard library - Ruby:
patterns = File.read('ruby/lib/.document').split("\n").map { |ln| ln.sub(/\#.*$/, '').strip }.reject(&:empty?)
  .map { |ln| "ruby/lib/#{ln}" }
  .grep_v(%r{/net/}).push('ruby/lib/net/{*,*.rb}') # net/* should be treated as separate libs; TODO: same for io/*

Dir[*patterns].group_by { |f| libname(f) } # group optparse.rb & optparse and so on
  .sort
  .each do |name, group|
    parse_modules(*group).each { |mod|
      write_mod("lib/#{name}", mod, source: name, reference: LIB_DOCS % name)
    }
  end

# Standard library - C:
Dir['ruby/ext/*'].grep_v(/-test-/).select(&File.method(:directory?))
  .sort
  .each do |path|
    name = File.basename(path)
    parse_modules(path).each do |mod|
      write_mod("ext/#{name}", mod, source: name, reference: LIB_DOCS % name)
    end
  end
