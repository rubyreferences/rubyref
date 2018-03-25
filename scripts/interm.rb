#!/usr/bin/env ruby

require 'rdoc'
require 'fileutils'
require 'pp'
require 'dry/inflector'

require_relative 'interm/utils'

MARKDOWN = RDoc::Markup::ToMarkdown.new

# TODO: currently rendered Ruby version
CORE_DOCS = 'http://ruby-doc.org/core-2.5.0'
LIB_DOCS = 'https://ruby-doc.org/stdlib-2.5.0/libdoc/%s/rdoc'

def parse_docs
  Dir['ruby/doc/{,**/}*.rdoc'].grep_v(/\.ja\./).sort.each do |source|
    write source.sub('ruby/', '').sub('.rdoc', ''),
      MARKDOWN.convert(File.read(source)),
      source: source
  end
end

def parse_core
  Dir['ruby/{,**/}*.c'].grep_v(%r{/(ext|missing)/}).
    tap do |pathes|
      parse_modules(*pathes).each { |mod| write_mod('core',  mod, reference: CORE_DOCS) }
    end
end

def parse_lib
  patterns = File.read('ruby/lib/.document').split("\n").map { |ln| ln.sub(/\#.*$/, '').strip }.reject(&:empty?)
    .map { |ln| "ruby/lib/#{ln}" }
    .grep_v(%r{/net}).push('ruby/lib/net/{*,*.rb}') # net/* should be treated as separate libs; TODO: same for io/ ext

  Dir[*patterns].group_by { |f| libname(f) } # group optparse.rb & optparse and so on
    .sort
    .each do |name, group|
      parse_modules(*group.uniq).each { |mod|
        write_mod("lib/#{name}", mod, source: name, reference: LIB_DOCS % name)
      }
    end
end

def parse_ext
  Dir['ruby/ext/*'].grep_v(/-test-/).select(&File.method(:directory?))
    .sort
    .each do |path|
      name = File.basename(path)
      parse_modules(path).each do |mod|
        write_mod("ext/#{name}", mod, source: name, reference: LIB_DOCS % name)
      end
    end
end

parse_docs
parse_core
parse_lib
parse_ext