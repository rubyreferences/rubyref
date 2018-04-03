#!/usr/bin/env ruby

require 'rdoc'
require 'fileutils'
require 'pp'
require 'dry/inflector'
require 'yaml'

require_relative 'parse/utils'

BOOK_RUBY_VERSION = File.read(File.expand_path('../config/ruby_version.txt', __dir__)).chomp
MARKDOWN = RDoc::Markup::ToMarkdown.new

CORE_REFERENCE = "https://ruby-doc.org/core-#{BOOK_RUBY_VERSION}.0"
LIB_REFERENCE = "https://ruby-doc.org/stdlib-#{BOOK_RUBY_VERSION}.0/libdoc/%s/rdoc"

OUT = File.expand_path('../intermediate/parsed', __dir__)

def parse_docs
  puts "Parsing doc/ folder..."

  Dir[rubypath('doc/{,**/}*.rdoc')].grep_v(/\.ja\./).sort.each do |source|
    write source.sub(rubypath('.'), '').sub('.rdoc', ''),
      MARKDOWN.convert(File.read(source)),
      source: source
  end
end

def parse_core
  puts "Parsing core objects documentation..."

  Dir[rubypath('{,**/}*.c')].grep_v(%r{/(ext|missing)/}).
    tap do |pathes|
      parse_modules(*pathes).each { |mod|
        write_kernel(mod) if mod.full_name == 'Kernel'
        write_mod('core',  mod, reference: CORE_REFERENCE)
      }
    end
end

def write_kernel(mod)
  config = YAML.load_file(File.expand_path('../config/kernel.yml', __dir__))
    .map { |h| h.transform_keys(&:to_sym) }

  methods = mod.method_list
  FileUtils.mkdir_p "#{OUT}/_special/"
  out = File.open("#{OUT}/_special/kernel.md", 'w')
  config.each do |section|
    out.puts "\n## #{section[:section]}\n\n" if section.key?(:section)
    section[:methods].sort.each { |name|
      method = methods.detect { |m| m.name == name } or fail "Method #{name} not found in Kernel"
      comment = MARKDOWN.convert(method.comment.parse).match(/\A(.*?([.;]\s|\z))/m)[1].strip.tr("\n", ' ')
      name = method.name
      case method.name
      when 'exec'
        comment.sub!(/(?<=the given external \*command\*).+$/, '.')
      when 'caller'
        comment.sub!("in `method'", "in 'method'")
      when /__(.+)__/
        name = "\\_\\_#{$1}\\_\\_"
      when '`'
        name = '\\`'
      end

      out.puts "* [#{name}](ref:Kernel##{method.name}): #{comment}\n"
    }
  end
end

def parse_lib
  puts "Parsing standard libraries (Ruby) documentation..."

  patterns = File.read(rubypath('lib/.document')).split("\n").map { |ln| ln.sub(/\#.*$/, '').strip }.reject(&:empty?)
    .map { |ln| rubypath("lib/#{ln}") }
    .grep_v(%r{/net}).push(rubypath('lib/net/{*,*.rb}')) # net/* should be treated as separate libs

  Dir[*patterns].group_by { |f| libname(f) } # group optparse.rb & optparse and so on
    .sort
    .each do |name, group|
      parse_modules(*group.uniq).each { |mod|
        write_mod("lib/#{name}", mod, source: name, reference: LIB_REFERENCE % name)
      }
    end
end

def parse_ext
  puts "Parsing standard libraries (C extensions) documentation..."

  Dir[rubypath('ext/*')].grep_v(/-test-/).select(&File.method(:directory?))
    .sort
    .each do |path|
      name = File.basename(path)
      parse_modules(path).each do |mod|
        write_mod("ext/#{name}", mod, source: name, reference: LIB_REFERENCE % name)
      end
    end
end

parse_docs
# parse_core
# parse_lib
# parse_ext