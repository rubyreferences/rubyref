class Content
  # Yes, it is ridiculous. A bit :shrug:
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
    # Top good-looking header is ##, all other should be deeper
    @header_shift = header_shift&.to_i || (index.zero? ? 1 : 2)
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
    Renderer
      .convert(@text.root, md_path: @owner.md_path, book: @owner.book, md_source: @source).first
      .gsub(/^(?=\#[a-z])/, '\\')       # Again! New methods could be at the beginning of the line after Kramdown render
      .gsub(/([`'])\\:\s/, '\1: ')      # IDK why Kramdown turns "`something`: definition" into "`something`\: definition"
      .gsub_r(/(https?:\S+)\\_/, '\1_') # Kramdown helpfully screens _ in URLs... And then GitBook screens them again.
  end

  private

  def parse_source(source, main: false)
    parse_file(source) ||               # "dir/doc.md"
      Kramdown::Document.new(source)    # "## Header"
        .tap { @header_shift = 0 if main } # do not shift headers of verbatim
  end

  def parse_file(path)
    return unless path =~ /^\S+\.md$/

    full_path = source_path(path)
    File.file?(full_path) or fail "Path not found: #{full_path}"

    Kramdown::Document.new(postprocess_raw(full_path, File.read(full_path)))
  end

  def book
    @owner.book
  end

  def source_path(path)
    if path.match(/^(content|ruby-lang\.org)/)
      File.join(book.root, path)
    else
      File.join(book.root, 'intermediate/sanitized', path)
    end
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
        .tap { |els| els.empty? and fail "Section #{section} not found in #{@source}!" }
        .take_while { |e| e.type != :header || e.options[:raw_text] == section }
    end
  end

  def postprocess_raw(path, source)
    if path.include?('ruby-lang.org')
      source = source
        .sub(/\A---\n.+?\n---\n/m, '')  # YAML frontmatter
        .gsub(/\{:.+?\}/, '')           # {: .foo} tags
        .gsub(/\{% highlight (sh|ruby|c) %\}\n.+?\n\{% endhighlight %\}/m) { |str| # Shell commands, Ruby code
          str.gsub(/\{%.+?%\}/, '').gsub(/^/, '    ')
        }
        .gsub(/\{% highlight irb %\}\n.+?\n\{% endhighlight %\}/m) { |str|   # IRB
          # in one place it is too close to list above. ^ is Kramdown's end-of-block marker
          # https://kramdown.gettalong.org/syntax.html#eob-marker
          str.gsub(/\{%.+?%\}/, '').gsub(/^/, '    ').prepend("\n^\n")
        }
    end
    if path.end_with?('ruby-lang.org/en/documentation/installation/index.md')
      source.sub!(/\* \[Package Management Systems.+\(\#building-from-source\)/m, '')
    end
    @replace.inject(source) { |src, from:, to:| src.gsub(from, to) }
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

  def handle_require_stdlib(libname = nil)
    libname ||= @source.match(%r{lib/(net/[^/]+)})&.at(1) ||
      @source.match(%r{(?:lib|ext)/([^/]+)})&.at(1) or fail("Can't guess libname by #{@source}")

    elements.insert(0, *parse_source(REQ_STDLIB % libname).root.children)
  end
end
