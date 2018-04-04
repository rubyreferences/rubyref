require_relative '../core_ext'
require_relative 'chapter'

class Book
  META = {
    ruby_version: BOOK_RUBY_VERSION
  }

  def self.load(root, path)
    new(root, YAML.load_file(path))
  end

  attr_reader :root, :chapters

  def initialize(root, chapters)
    @root = root
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
    @all_pathes ||= all_chapters.map(&:md_path)

    return if @all_pathes.include?(full_path)
    candidates = DidYou::Spell.check(full_path, @all_pathes)
    fail "at #{context}: #{path} resolved to #{full_path}, but it does not exist. "\
         "Candidates: #{candidates.join(', ')}"
  end

  def meta
    Hm(META.merge(chapters: chapters.map(&:to_h))).transform_keys(&:to_s).to_h
  end

  def write(path)
    File.write File.join(path, '_data/book.yml'), meta.to_yaml
    chapters.each { |c| c.write(path) }
  end
end
