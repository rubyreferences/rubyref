module Linker
  # internal cross-links in doc/*.rdoc and some classes, we convert them into new structure of the book.
  RDOC_REF = {
    'syntax/precedence.rdoc' => '/language/precedence.md',
    'syntax/miscellaneous.rdoc' => '/language/misc.md',
    'syntax/modules_and_classes.rdoc' => '/language/modules-classes.md',
    'syntax/exceptions.rdoc' => '/language/exceptions.md',
    'syntax/control_expressions.rdoc' => '/language/control-expressions.md',
    'syntax/methods.rdoc' => '/language/methods-def.md',
    'syntax/literals.rdoc' => '/language/literals.md',
    'syntax/calling_methods.rdoc' => '/language/methods-call.md',
    'globals.rdoc' => '/language/globals.md',
    'syntax/refinements.rdoc' => '/language/refinements.md',
    'doc/security.rdoc' => '/advanced/security.md',
    'control_expressions_rdoc.html#label-Modifier+Statements' => '/language/control-expressions.md#modifier-statements',
    'syntax/pattern_matching.rdoc' => '/language/pattern-matching.md',
  }

  # internal links in installation.md, imported from site
  IGNORE_LINKS = %w[#rvm #rbenv #chruby #ruby-install #ruby-build #package-management-systems] +
    %w[#label-Character+Classes] + # internal link in Regexp docs
    %w[rdoc-ref:MakeMakefile] # in the depth of extensions.rdoc, too lazy to fix...

  CORE_METHOD_REFERENCE = "https://ruby-doc.org/core-#{BOOK_RUBY_VERSION}.0/%s.html#method-i-%s"
  LIB_MODULE_REFERENCE = "https://ruby-doc.org/stdlib-#{BOOK_RUBY_VERSION}.0/libdoc/%s/rdoc/%s.html"
  LIB_METHOD_REFERENCE = "https://ruby-doc.org/stdlib-#{BOOK_RUBY_VERSION}.0/libdoc/%s/rdoc/%s.html#method-i-%s"

  extend self

  def call(href)
    return if IGNORE_LINKS.include?(href)

    case href
    when /^rdoc-ref:(.+)$/
      RDOC_REF.fetch($1) { |key| fail "Unidentified rdoc-ref: #{key}" }
    when /^ref:(.+)$/
      reference_href($1)
    when /^[^:]+\.md(\#.+)?$/, /^(https?|ftp):/
      href
    when '/en/downloads/' # In installation.md
      'http://ruby-lang.org/en/downloads/'
    when %r{^/en} # Links from site to itself
      "http://ruby-lang.org#{href}"
    when /_rdoc\.html/ # some new code does it in a weird way...
      RDOC_REF.fetch(href) { |key| fail "Unidentified rdoc-ref: #{key}" }
    else
      fail "Unidentified link address: #{href}"
    end
  end

  private

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
end