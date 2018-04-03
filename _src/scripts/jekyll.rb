#!/usr/bin/env ruby

require 'fileutils'
require 'pp'
require 'dry/inflector'
require 'yaml'
require 'kramdown'
require 'hm'
require 'ripper'
require 'pathname'
require 'did_you'

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

class GFMConverter < Kramdown::Converter::Kramdown
  # class << self
  #   public :new
  # end

  # def initialize(tree, file_path, book)
  #   @file_path = file_path
  #   @book = book
  #   super(tree, ::Kramdown::Options.merge({}))
  # end

  def convert_codeblock(el, opts)
    "\n```#{code_lang(el.value)}\n#{el.value}```\n"
  end

  def code_lang(str)
    # If Ripper can't parse it, it is not Ruby (console output, or diagram, or whatever)
    Ripper.sexp(str).nil? ? '' : 'ruby'
  end

  def md_path
    @options[:file_path]
  end

  def book
    @options[:book]
  end

  def md_source
    @options[:md_source]
  end

  def reference_link(text)
    case text
    when /^([A-Z][a-zA-Z]+)\#([A-Za-z_]+[!?]?)$/
      mod, meth = $1, $2
      'https://ruby-doc.org/core-2.5.0/%s.html#method-i-%s' % [mod, meth.sub('?', '-3F').sub('!', '-21')]
    when 'Kernel#`'
      'https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-60'
    when %r{^(.+)/([A-Z][a-zA-Z]+)$}
      lib, mod = $1, $2
      'https://ruby-doc.org/stdlib-2.5.0/libdoc/%s/rdoc/%s.html' % [lib, mod]
    when %r{^(.+)/([A-Z][a-zA-Z]+)\#([a-z_]+\??)$}
      lib, mod, meth = $1, $2, $3
      'https://ruby-doc.org/stdlib-2.5.0/libdoc/%s/rdoc/%s.html#method-i-%s' % [lib, mod, meth.sub('?', '-3F')]
    else
      fail "Can't understand ref: link #{text} at #{md_path} (#{md_source}"
    end
  end

  # Kramdown converts HTTP links into [link][1] with list of links at the end of the doc. It is
  # not appropriate for our tasks. Plus, we want different styles for different kinds of external links.
  def convert_a(el, opts)
    href = el.attr['href']
    local = false
    real_href = case href
    when /^(https?|ftp):/
      el.attr['href']
    when /^rdoc-ref:(.+)$/
      RDOC_REF.fetch($1) { |key| warn "Unidentified rdoc-ref: #{key} at #{md_path}"; '#TODO' }
    when /^ref:(.+)$/
      reference_link($1)
    when /^[^:]+\.md(\#.+)?$/
      book.validate_link!(href, md_path, "#{md_path} (#{md_source})")
      local = true
      href
    when '#rvm', '#rbenv', '#chruby', '#ruby-install', '#ruby-build' # internal links in installation, imported from site
      return inner(el, opts)
    when '/en/downloads/'
      'http://ruby-lang.org/en/downloads/'
    else
      fail "Unidentified link address: #{href} at #{md_path} (#{md_source}"
    end

    if local
      "[#{inner(el, opts)}](#{real_href})"
    else
      t, el.type = el.type, :root
      el.options[:encoding] = 'UTF-8'
      inner = Kramdown::Converter::Html.convert(el).first
      el.type = t # Or it will have consequences on further rendering
      cls = real_href.match(%r{^https?://ruby-doc\.org}) ? "ruby-doc remote" : "remote"
      cls << " reference" if inner.end_with?(' Reference')
      "<a href='#{real_href}' class='#{cls}' target='_blank'>#{inner}</a>"
    end
  end
end

class ContentPart
  def initialize(
    index:,
    source:,
    owner:,
    header_shift: nil,
    remove: [],
    insert: [],
    process: [],
    sections: [],
    remove_sections: [],
    replace: [],
    **)

    @owner = owner
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
    GFMConverter
      .convert(@text.root, file_path: @owner.file_path, book: @owner.book, md_source: @source).first
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
    full_path = path.match(/^(content|www\.ruby-lang\.org)/) ? path : File.join(SOURCE, path)
    return unless File.file?(full_path)

    Kramdown::Document.new(postprocess_raw(full_path, File.read(full_path)))
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

  def postprocess_raw(path, source)
    if path.start_with?('www.ruby-lang.org')
      source = source
        .sub(/\A---\n.+?\n---\n/m, '')  # YAML frontmatter
        .gsub(/\{:.+?\}/, '')           # {: .foo} tags
        .gsub(/\{% highlight sh %\}\n.+?\n\{% endhighlight %\}/m) { |str|   # Shell commands
          str.gsub(/\{%.+?%\}/, '').gsub(/^/, '    ')
        }
    end
    if path == 'www.ruby-lang.org/en/documentation/installation/index.md'
      source.sub!(/\* \[Package Management Systems.+\(\#building-from-source\)/m, '')
    end
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
  attr_reader :book, :id, :title, :parent, :children, :content_chunks
  attr_accessor :prev_chapter, :next_chapter

  def self.parse(hash, book, parent: nil)
    new(book, parent: parent, **hash.transform_keys(&:to_sym))
  end

  def initialize(book, title:, id: nil, parent: nil, part: false, children: [], content: [])
    @book = book

    # "Modules and Classes" => "modules-classes"
    @id = id || title.downcase.gsub(' and ', ' ').tr(' ', '-')
    @title = title
    @part = part
    @parent = parent
    @children = children.map { |c| Chapter.parse(c, book, parent: self) }
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
    "/#{dir_path}.html"
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

  def with_children
    [self, *children.flat_map(&:with_children)]
  end

  def front_matter
    {
      title: title,
      prev: prev_chapter&.html_path,
      next: next_chapter&.html_path,
    }.compact.transform_keys(&:to_s)
  end

  def write
    unless part?
      FileUtils.mkdir_p File.dirname(full_path)
      File.write(full_path,
        "#{front_matter.to_yaml}---\n\n" +
        content_chunks.map(&:render).join("\n\n")
      )
    end
    # puts "Writing #{id} #{title} #{full_path}"
    children.each(&:write)
  end
end

class Book
  def self.load
    new(YAML.load_file('config/structure.yml'))
  end

  attr_reader :chapters

  def initialize(chapters)
    @chapters = chapters.map { |c| Chapter.parse(c, self) }
    all_chapters.each_cons(2) { |before, after|
      before.next_chapter = after
      after.prev_chapter = before
    }
  end

  def all_chapters
    @chapters.map(&:with_children).flatten
  end

  def validate_link!(path, relative_to, context)
    path, anchor = path.split('#', 2) # TODO: check if this anchor links anywhere?
    full_path = (Pathname.new(relative_to).dirname + path).to_s
    @all_pathes ||= all_chapters.map(&:file_path)

    return if @all_pathes.include?(full_path)
    candidates = DidYou::Spell.check(full_path, @all_pathes)
    fail "at #{context}: #{path} resolved to #{full_path}, but it does not exist. Candidates: #{candidates.join(', ')}"
  end

  META = {
    ruby_version: RUBY_VERSION # TODO: version for which we are generating
  }

  def meta
    Hm(META.merge(chapters: chapters.map(&:to_h))).transform_keys(&:to_s).to_h
  end

  LEAVE = %r{jekyll/(README|_|Gemfile|css|js|images)}

  def write
    Dir['jekyll/*'].grep_v(LEAVE).each(&FileUtils.method(:rm_rf))
    File.write 'jekyll/_data/book.yml', meta.to_yaml
    chapters.each(&:write)
    FileUtils.touch 'jekyll/README.md'
  end
end

Book.load.write