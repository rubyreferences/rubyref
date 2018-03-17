require 'fileutils'
require 'pp'
require 'dry/inflector'
require 'yaml'
require 'kramdown'

INFLECTOR = Dry::Inflector.new

SOURCE = 'intermediate/sanitized/'

class GFMKonverter < Kramdown::Converter::Kramdown
  # FIXME: very naive, should check if it is proper Ruby code or not
  def convert_codeblock(el, opts)
    "\n```ruby\n#{el.value}```\n"
  end
end

class ContentPart
  def initialize(index:, source:, header_shift: nil, **)
    @index = index
    @header_shift = header_shift&.to_i || (index.zero? ? 0 : 1)
    @source = parse_source(source)
  end

  def render
    doc = Kramdown::Document.new(@source)

    doc.root.children.each { |c|
      c.options[:level] += @header_shift if c.type == :header
    }
    GFMKonverter.convert(doc.root).first
      .gsub(/^(?=\#[a-z])/, '\\') # Again! New methods could be at the beginning of the line after Kramdown render
  end

  private

  def parse_source(source)
    # allow raw markdown
    return source unless File.file?(source) || File.file?(File.join(SOURCE, source))

    path = source.start_with?('content') ? source : File.join(SOURCE, source)

    File.read(path)
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

  def full_path
    File.join('book', file_path)
  end

  def depth
    return -1 if part?

    parent ? parent.depth + 1 : 0
  end

  def write
    unless part?
      FileUtils.mkdir_p File.dirname(full_path)
      File.write full_path, content_chunks.map(&:render).join("\n\n")
    end
    puts "Writing #{id} #{title} #{full_path}"
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
    HEADER + chapters.map(&:toc_entry).join("\n")
  end

  def write
    # Don't remove README for GitBook server not to get broken every time
    Dir['book/*'].grep_v(%r{book/README}).each(&FileUtils.method(:rm_rf))
    FileUtils.mkdir_p('book')
    chapters.each(&:write)
    File.write 'book/SUMMARY.md', toc
    FileUtils.touch 'book/README.md'
  end
end

Book.load.write