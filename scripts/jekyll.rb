#!/usr/bin/env ruby

require 'fileutils'
require 'pp'
require 'dry/inflector'
require 'yaml'
require 'kramdown'
require 'hm'
require 'ripper'

INFLECTOR = Dry::Inflector.new

SOURCE = 'intermediate/sanitized/'
OUT = 'jekyll'

class String
  # Recursive gsub. Repeats till anything replaced.
  def gsub_r(pattern, sub)
    res = gsub(pattern, sub)
    res == self ? res : res.gsub_r(pattern, sub)
  end
end

# Otherwise Ripper would spit some warnings on sterr
def Warning.warn(*); end

RDOC_REF = {
  'syntax/precedence.rdoc' => '/language/precedence.md',
  'syntax/miscellaneous.rdoc' => '/language/misc.md',
  'syntax/modules_and_classes.rdoc' => '/language/modules-classes.md',
  'syntax/exceptions.rdoc' => '/language/exceptions.md',
  'syntax/control_expressions.rdoc' => '/language/control_expressions.md',
  'syntax/methods.rdoc' => '/language/methods-def.md',
  'syntax/literals.rdoc' => '/language/literals.md',
  'syntax/calling_methods.rdoc' => '/language/method-call.md',
  'globals.rdoc' => '/language/globals.md',
  'syntax/refinements.rdoc' => '/language/refinements.md'
}

class GFMKonverter < Kramdown::Converter::Kramdown
  def convert_codeblock(el, opts)
    "\n```#{code_lang(el.value)}\n#{el.value}```\n"
  end

  def code_lang(str)
    # If Ripper can't parse it, it is not Ruby (console output, or diagram, or whatever)
    Ripper.sexp(str).nil? ? '' : 'ruby'
  end

  # Kramdown converts HTTP links into [link][1] with list of links at the end of the doc. It is
  # not appropriate for our tasks
  def convert_a(el, opts)
    case el.attr['href']
    when /^(https?|ftp):/
      "[#{inner(el, opts)}](#{el.attr['href']})"
    when /^(rdoc-ref):(.+)$/
      reference = RDOC_REF.fetch($2) { |key| puts "REF: #{key}"; '#TODO' }
      "[#{inner(el, opts)}](#{reference})"
    else
      super
    end
  end
end

class ContentPart
  def initialize(
    index:,
    source:,
    header_shift: nil,
    remove: [],
    insert: [],
    process: [],
    sections: [],
    remove_sections: [],
    replace: [],
    **)

    @index = index
    @header_shift = header_shift&.to_i || (index.zero? ? 0 : 1)
    @remove = Array(remove)
    @sections = Array(sections)
    @remove_sections = Array(remove_sections)
    @insert = insert.map { |i| i.transform_keys(&:to_sym) }
    @process = Array(process).map(&method(:Array))
    @replace = replace.map { |r| r.transform_keys(&:to_sym) }
    @source = source
    @text = parse_source(@source, main: true)
    postprocess
  end

  def render
    GFMKonverter.convert(@text.root).first
      .gsub(/^(?=\#[a-z])/, '\\')       # Again! New methods could be at the beginning of the line after Kramdown render
      .gsub(/([`'])\\:\s/, '\1: ')      # IDK why Kramdown turns "`something`: definition" into "`something`\: definition"
      .gsub_r(/(https?:\S+)\\_/, '\1_') # Kramdown helpfully screens _ in URLs... And then GitBook screens them again.
  end

  private

  def parse_source(source, main: false)
    parse_file(source) ||               # "dir/doc.md"
      parse_partial(source) ||          # "dir/doc.md#Section"
      Kramdown::Document.new(source)    # "## Header"
        .tap { @header_shift = 0 if main } # do not shift headers of verbatim
  end

  def parse_file(path)
    full_path = path.start_with?('content') ? path : File.join(SOURCE, path)
    return unless File.file?(full_path)

    Kramdown::Document.new(postprocess_raw(File.read(full_path)))
  end

  def parse_partial(path)
    m = path.match(/^(\S+\.md)\#(.+)$/) or return
    path, section = m.values_at(1, 2)

    parse_file(path)
      .tap { |doc|
        doc or fail "Source for partial not found: #{path}"

        if section == '_ref' # special syntax to borrow the "[ClassName Reference](...)" link
          ref = doc.root.children.select { |e| convert(e).match(/^\[\S+ Reference\]/) }
          ref.empty? and fail "Reference not found: #{path}"
          doc.root.children.replace(ref)
        else
          doc.root.children
            .drop_while { |e| e.type != :header || e.options[:raw_text] != section }
            .tap { |els| els.empty? and fail "Section #{section} not found in #{path}" }
            .take_while { |e| e.type != :header || e.options[:raw_text] == section }
            .tap { |els| doc.root.children.replace(els) }
        end
      }
  end

  def convert(el)
    el.options[:encoding] = 'UTF-8'
    Kramdown::Converter::Kramdown.convert(el, line_width: 1000).first
  end

  def elements
    @text.root.children
  end

  def para_idx(what)
    elements.find_index { |c| convert(c).start_with?(what) } or
        fail "String #{what} not found in #{@source}"
  end

  def remove_section(section)
    els = elements.dup
    before = els.take_while { |e| e.type != :header || e.options[:raw_text] != section }
    els = els[before.size..-1]
    els.empty? and fail "Section #{section} not found"
    inside = els.take_while { |e| e.type != :header || e.options[:raw_text] == section }
    after = els[inside.size..-1]

    # For example, we want to drop last section (# Contribution), but preserve [Docs Reference] after it
    if reference = inside.detect { |ref| convert(ref).match(/^\[\S+ Reference\]/) }
      before.push(reference)
    end

    elements.replace(before + after)
  end

  def select_section(section)
    if section == '_ref' # special syntax to borrow the "[ClassName Reference](...)" link
      elements
        .select { |e| convert(e).match(/^\[\S+ Reference\]/) }
        .tap { |ref| ref.empty? and fail "Reference not found!" }
    else
      elements
        .drop_while { |e| e.type != :header || e.options[:raw_text] != section }
        .tap { |els| els.empty? and fail "Section #{section} not found!" }
        .take_while { |e| e.type != :header || e.options[:raw_text] == section }
    end
  end

  def postprocess_raw(source)
    @replace.inject(source) { |src, r| src.gsub(r[:from], r[:to]) }
  end

  def postprocess
    unless @sections.empty?
      elements.replace(@sections.flat_map { |title| select_section(title) })
    end
    @process.each do |what, *arg|
      send("handle_#{what}", *arg)
    end
    @remove_sections.each do |title|
      remove_section(title)
    end
    @remove.each do |rem|
      idx = para_idx(rem)
      elements.delete_at(idx)
    end
    @insert.each do |after:, source:|
      idx = para_idx(after)
      source = parse_source(source)
      elements.insert(idx + 1, *source.root.children)
    end
    elements.each { |c|
      c.options[:level] += @header_shift if c.type == :header
    }
  end

  STDLIB = <<~DOC
    _Part of standard library. You need to `require '%s'` before using._

  DOC

  REQ_STDLIB = "    require '%s'\n\n"

  def handle_stdlib(libname)
    idx = para_idx('#') # First header
    elements.insert(idx + 1, *parse_source(STDLIB % libname).root.children)
  end

  class ::MatchData
    def at(i); self[i] end
  end

  def handle_require_stdlib(libname = nil)
    libname ||= @source.match(%r{lib/(net/[^/]+)})&.at(1) ||
      @source.match(%r{(?:lib|ext)/([^/]+)})&.at(1) or fail("Can't guess libname by #{@source}")

    elements.insert(0, *parse_source(REQ_STDLIB % libname).root.children)
  end
end

class Chapter
  attr_reader :id, :title, :parent, :children, :content_chunks

  def self.parse(hash, parent: nil)
    new(parent: parent, **hash.transform_keys(&:to_sym))
  end

  def initialize(title:, id: nil, parent: nil, part: false, children: [], content: [])
    # "Modules and Classes" => "modules-classes"
    @id = id || title.downcase.gsub(' and ', ' ').tr(' ', '-')
    @title = title
    @part = part
    @parent = parent
    @children = children.map { |c| Chapter.parse(c, parent: self) }
    @content_chunks = content.each_with_index.map { |c, i|
      ContentPart.new(index: i, owner: self, **c.transform_keys(&:to_sym))
    }
  end

  def part?
    @part
  end

  def dir_path
    File.join(*[parent&.dir_path, id].compact)
  end

  def file_path
    "#{dir_path}.md"
  end

  def html_path
    "#{dir_path}.html"
  end

  def full_path
    File.join(OUT, file_path)
  end

  def depth
    return -1 if part?

    parent ? parent.depth + 1 : 0
  end

  def to_h
    {
      title: title,
      path: html_path,
      children: (children.map(&:to_h) unless children.empty?)
    }.compact
  end

  def write
    unless part?
      FileUtils.mkdir_p File.dirname(full_path)
      File.write full_path, content_chunks.map(&:render).join("\n\n")
    end
    # puts "Writing #{id} #{title} #{full_path}"
    children.each(&:write)
  end

  def toc_entry
    if part?
      "\n## #{title}\n\n"
    else
      "%s* [%s](%s)\n" % ['  ' * depth, title, file_path]
    end + children.map(&:toc_entry).join("\n")
  end
end

class Book
  def self.load
    new(YAML.load_file('config/structure.yml').map(&Chapter.method(:parse)))
  end

  attr_reader :chapters

  def initialize(chapters)
    @chapters = chapters
  end

  HEADER = <<~TOC
    # The Ruby Reference
  TOC

  def toc
    Hm(chapters: chapters.map(&:to_h)).transform_keys(&:to_s).to_h
  end

  LEAVE = %r{jekyll/(README|_|Gemfile|css|js)}

  def write
    Dir['jekyll/*'].grep_v(LEAVE).each(&FileUtils.method(:rm_rf))
    File.write 'jekyll/_data/book.yml', toc.to_yaml
    chapters.each(&:write)
    FileUtils.touch 'jekyll/README.md'
  end
end

Book.load.write