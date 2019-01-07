class Linker
  RDOC_REF = {
    'syntax/precedence.rdoc' => 'language/precedence.md',
    'syntax/miscellaneous.rdoc' => 'language/misc.md',
    'syntax/modules_and_classes.rdoc' => 'language/modules-classes.md',
    'syntax/exceptions.rdoc' => 'language/exceptions.md',
    'syntax/control_expressions.rdoc' => 'language/control-expressions.md',
    'syntax/methods.rdoc' => 'language/methods-def.md',
    'syntax/literals.rdoc' => 'language/literals.md',
    'syntax/calling_methods.rdoc' => 'language/methods-call.md',
    'globals.rdoc' => 'language/globals.md',
    'syntax/refinements.rdoc' => 'language/refinements.md',
    'doc/security.rdoc' => 'advanced/security.md'
  }
  # internal links in installation.md, imported from site
  IGNORE_LINKS = %w[#rvm #rbenv #chruby #ruby-install #ruby-build #package-management-systems]

  # CORE_METHOD_REFERENCE = "https://ruby-doc.org/core-#{BOOK_RUBY_VERSION}.0/%s.html#method-i-%s"
  # LIB_MODULE_REFERENCE = "https://ruby-doc.org/stdlib-#{BOOK_RUBY_VERSION}.0/libdoc/%s/rdoc/%s.html"
  # LIB_METHOD_REFERENCE = "https://ruby-doc.org/stdlib-#{BOOK_RUBY_VERSION}.0/libdoc/%s/rdoc/%s.html#method-i-%s"

  # For 2.6, ruby-doc renders /2.6/
  CORE_METHOD_REFERENCE = "https://ruby-doc.org/core-#{BOOK_RUBY_VERSION}/%s.html#method-i-%s"
  LIB_MODULE_REFERENCE = "https://ruby-doc.org/stdlib-#{BOOK_RUBY_VERSION}/libdoc/%s/rdoc/%s.html"
  LIB_METHOD_REFERENCE = "https://ruby-doc.org/stdlib-#{BOOK_RUBY_VERSION}/libdoc/%s/rdoc/%s.html#method-i-%s"

  def initialize(converter, book:, md_path:, md_source:, **)
    @converter = converter
    @md_path = md_path
    @book = book
    @md_source = md_source
  end

  def call(element, opts)
    inner_text = inner(element, opts)
    return inner_text if IGNORE_LINKS.include?(element.attr['href'])

    href = prepare_href(element.attr['href'])

    if href.match?(/^https?:/)
      remote_link(inner_text, href)
    else
      @book.validate_link!(href, @md_path, "#{@md_path} (#{@md_source})")
      "[#{inner_text}](#{href})"
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
        'language.md'
      }.yield_self { |lnk|
        depth = @md_path.count('/')
        if @md_path.start_with?('language/')
          '../' * (depth - 1) + lnk.sub('language/', '')
        else
          '../' * depth + lnk
        end
      }
    when /^ref:(.+)$/
      reference_href($1)
    when /^[^:]+\.md(\#.+)?$/
      href
    when '/en/downloads/' # In installation.md
      'http://ruby-lang.org/en/downloads/'
    when %r{^/en} # Links from site to itself
      "http://ruby-lang.org#{href}"
    else
      fail "Unidentified link address: #{href} at #{@md_path} (#{@md_source})"
    end
  end

  def remote_link(inner_text, href)
    cls = href.match(%r{^https?://ruby-doc\.org}) ? "ruby-doc remote" : "remote"

    "<a href='#{href}' class='#{cls}' target='_blank'>#{inner_text}</a>"
  end
end