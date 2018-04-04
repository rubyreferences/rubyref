require_relative 'content'
require_relative 'renderer'

class Chapter
  attr_reader :book, :id, :title, :parent, :children, :md_path, :html_path
  attr_accessor :prev_chapter, :next_chapter

  def self.parse(hash, book, parent: nil)
    new(book, parent: parent, **hash.transform_keys(&:to_sym))
  end

  def initialize(book, title:, id: nil, md_path: nil, html_path: nil, parent: nil, children: [], content: [])
    @book = book

    # "Modules and Classes" => "modules-classes"
    @id = id || title.downcase.gsub(' and ', ' ').tr(' ', '-')
    @title = title
    @parent = parent
    @children = children.map { |c| Chapter.parse(c, book, parent: self) }
    @md_path = md_path || "#{dir_path}.md"
    @html_path = html_path || "/#{dir_path}.html"
    @content = content.each_with_index.map { |c, i|
      Content.new(index: i, owner: self, **c.transform_keys(&:to_sym))
    }
  end

  def dir_path
    File.join(*[parent&.dir_path, id].compact)
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
      permalink: ('/index.html' if md_path == 'README.md') # :shrug:
    }.compact.transform_keys(&:to_s)
  end

  def write(dir)
    full_path = File.join(dir, md_path)
    FileUtils.mkdir_p File.dirname(full_path)
    File.write full_path,
      "#{front_matter.to_yaml}---\n\n" +
      @content.map(&:render).join("\n\n")
    children.each { |c| c.write(dir) }
  end
end
