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
    @source.root.children.each { |c|
      c.options[:level] += @header_shift if c.type == :header
    }
    GFMKonverter.convert(@source.root).first
      .gsub(/^(?=\#[a-z])/, '\\') # Again! New methods could be at the beginning of the line after Kramdown render
      .gsub(/`\\:\s/, '`: ') # IDK why Kramdown turns "`something`: definition" into "`something`\: definition"
  end

  private

  def parse_source(source)
    parse_file(source) ||               # "dir/doc.md"
      parse_partial(source) ||          # "dir/doc.md#Section"
      Kramdown::Document.new(source)    # "## Header"
  end

  def parse_file(path)
    full_path = path.start_with?('content') ? path : File.join(SOURCE, path)
    return unless File.file?(full_path)

    Kramdown::Document.new(File.read(full_path))
  end

  def parse_partial(path)
    m = path.match(/^(\S+\.md)\#(.+)$/) or return
    path, section = m.values_at(1, 2)

    parse_file(path)
      .tap { |doc|
        doc or fail "Source for partial not found: #{path}"

        doc.root.children
          .drop_while { |e| e.type != :header || e.options[:raw_text] != section }
          .tap { |els| els.empty? and fail "Section #{section} not found in #{path}" }
          .take_while { |e| e.type != :header || e.options[:raw_text] == section }
          .tap { |els| doc.root.children.replace(els) }
      }
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
    File.write 'book/SUMMARY.md', toc
    chapters.each(&:write)
    FileUtils.touch 'book/README.md'
  end
end

Book.load.write