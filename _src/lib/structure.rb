class Structure
  PATH = File.expand_path('../config/structure.yml', __dir__)

  class Part < OpenStruct
    KINDS = {
      nil => :literal,
      /^core/ => :core,
      /^doc/ => :doc,
      /^ruby-lang\.org/ => :site,
      /^content/ => :content,
      /^lib/ => :lib,
      /^ext/ => :ext,
      /^_special/ => :special
    }

    def initialize(source:, **definition)
      # FIXME: This is weak...
      path = source unless source.include?(' ')
      super(
        source: source,
        path: path,
        **definition
      )
    end

    def kind
      KINDS.detect { |pat,| pat === path }&.last or fail ArgumentError, "Can't detect kind for #{path.inspect}"
    end

    KINDS.values.each { |sym| define_method("#{sym}?") { kind == sym } }

    def from_repo?
      %i[doc core lib ext].include?(kind)
    end

    def src_path
      case
      when doc?
        "ruby/#{path.sub('.md', '.rdoc')}"
      end
    end

    def lib_name
      case
      when ext?
        File.dirname(path).sub('ext/', '')
      when lib?
        File.dirname(path).sub('lib/', '')
      end
    end

    def module_name
      case
      when core?, ext?, lib?
        File.basename(path, '.*').tr('-', ':')
      else
        fail "No module_name can be defined for #{path}"
      end
    end

    def raw_path
      case
      when ignore?
        nil
      when from_repo?
        "intermediate/parsed/#{path}"
      when site?
        path
      end
      # nil -- no "raw" path for content and literal and special
    end

    def ready_path
      case
      when ignore?
        nil
      when from_repo?, site?
        "intermediate/sanitized/#{path}"
      when content?
        path
      end
      # nil -- no "raw" path for literal
    end

    def ignore?
      ignore
    end
  end

  class Chapter < OpenStruct
    def initialize(children: [], content: [], id: nil, descriptor: [], title:, **definition)
      # "Modules and Classes" => "modules-classes"
      id ||= title.downcase.gsub(' and ', ' ').tr(' ', '-')
      descriptor = [*descriptor, id]
      super(
        id: id,
        title: title,
        descriptor: descriptor,
        children: children.map { Chapter.new(descriptor: descriptor, **_1) },
        parts: content.map { Part.new(**_1) },
        **definition
      )
    end

    def out_path
      '../' + (md_path || descriptor.join('/') + '.md')
    end

    def html_path
      '/' + descriptor.join('/') + '.html'
    end

    def each_nested(&block)
      yield self
      children.each { _1.each_nested(&block) }
    end
  end

  def self.load
    new(YAML.load_file(PATH).map { Hm(_1).transform_keys(&:to_sym).to_h })
  end

  attr_reader :top_chapters

  def initialize(source)
    @top_chapters = source.map { Chapter.new(**_1) }
    each_chapter.each_cons(2) do |b, a|
      a.prev_chapter = b
      b.next_chapter = a
    end
  end

  def each_chapter(&block)
    return to_enum(__method__) unless block_given?

    @top_chapters.each { _1.each_nested(&block) }
  end

  def each_part(&block)
    return to_enum(__method__) unless block_given?

    each_chapter { _1.parts.each(&block) }
  end
end