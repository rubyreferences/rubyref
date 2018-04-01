#!/usr/bin/env ruby

require 'rdoc'
require 'fileutils'
require 'pp'
require 'dry/inflector'
require 'yaml'

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
      parse_modules(*pathes).each { |mod|
        write_kernel(mod) if mod.full_name == 'Kernel'
        write_mod('core',  mod, reference: CORE_DOCS)
      }
    end
end

def write_kernel(mod)
  config = YAML.load_file('config/kernel.yml').map { |h| h.transform_keys(&:to_sym) }
  methods = mod.method_list
  FileUtils.mkdir_p 'intermediate/parsed/_special/'
  out = File.open("#{INTERM}/_special/kernel.md", 'w')
  config.each do |section|
    out.puts "\n## #{section[:section]}\n\n" if section.key?(:section)
    section[:methods].sort.each { |name|
      method = methods.detect { |m| m.name == name } or fail "Method #{name} not found in Kernel"
      comment = MARKDOWN.convert(method.comment.parse).match(/\A(.+?([.;]\s|\z))/m)[1].strip.tr("\n", ' ')
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

# parse_docs
parse_core
# parse_lib
# parse_ext