class Linker
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
  # internal links in installation.md, imported from site
  IGNORE_LINKS = %w[#rvm #rbenv #chruby #ruby-install #ruby-build]

  CORE_METHOD_REFERENCE = "https://ruby-doc.org/core-#{BOOK_RUBY_VERSION}.0/%s.html#method-i-%s"
  LIB_MODULE_REFERENCE = "https://ruby-doc.org/stdlib-#{BOOK_RUBY_VERSION}.0/libdoc/%s/rdoc/%s.html"
  LIB_METHOD_REFERENCE = "https://ruby-doc.org/stdlib-#{BOOK_RUBY_VERSION}.0/libdoc/%s/rdoc/%s.html#method-i-%s"

  def initialize(converter, book:, file_path:, md_source:, **)
    @converter = converter
    @md_path = file_path
    @book = book
    @md_source = md_source
  end

  def call(element, opts)
    return inner(el, opts) if IGNORE_LINKS.include?(element['href'])

    href = prepare_href(element['href'])

    if href.match?(/^https?:/)
      remote_link(element, href)
    else
      "[#{inner(el, opts)}](#{real_href})"
    end
  end

  private

  def inner(el, opts)
    @converter.__send__(:inner, el, opts)
  end

  def reference_href(text)
    case text
    when /^([A-Z][a-zA-Z]+)\#([A-Za-z_]+[!?]?)$/
      mod, meth = $1, $2
      CORE_METHOD_REFERENCE % [mod, meth.sub('?', '-3F').sub('!', '-21')]
    when 'Kernel#`'
      "https://ruby-doc.org/core-#{BOOK_RUBY_VERSION}.0/Kernel.html#method-i-60"
    when %r{^(.+)/([A-Z][a-zA-Z]+)$}
      lib, mod = $1, $2
      LIB_MODULE_REFERENCE % [lib, mod]
    when %r{^(.+)/([A-Z][a-zA-Z]+)\#([a-z_]+\??)$}
      lib, mod, meth = $1, $2, $3
      LIB_METHOD_REFERENCE % [lib, mod, meth.sub('?', '-3F')]
    else
      fail "Can't understand reference: link #{text} at #{@md_path} (#{@md_source}"
    end
  end

  def prepare_href(href)
    case href
    when /^(https?|ftp):/
      href
    when /^rdoc-ref:(.+)$/
      RDOC_REF.fetch($1) { |key|
        puts "Unidentified rdoc-ref: #{key} at #{@md_path} (#{@md_source})"
        '#TODO'
      }
    when /^ref:(.+)$/
      reference_href($1)
    when /^[^:]+\.md(\#.+)?$/
      @book.validate_link!(href, @md_path, "#{@md_path} (#{@md_source})")
      href
    when '/en/downloads/' # In installation.md
      'http://ruby-lang.org/en/downloads/'
    else
      fail "Unidentified link address: #{href} at #{@md_path} (#{@md_source})"
    end
  end

  def remote_link(el, href)
    inner_html = el.dup
      .tap { |e|
        e.type = :root
        e.options[:encoding] = 'UTF-8'
      }
      .yield_self(&Kramdown::Converter::Html.method(:convert))
      .first

    cls = href.match(%r{^https?://ruby-doc\.org}) ? "ruby-doc remote" : "remote"

    "<a href='#{href}' class='#{cls}' target='_blank'>#{inner_html}</a>"
  end
end