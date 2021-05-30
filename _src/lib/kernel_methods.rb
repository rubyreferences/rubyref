module KernelMethods
  CONFIG = YAML.load_file('config/kernel.yml').map { _1.transform_keys(&:to_sym) }
  RDOC_TO_MARKDOWN = RDoc::Markup::ToMarkdown.new
  IGNORED_METHODS = [
    'chomp', 'chop', 'gsub', 'sub', # useful in one-liners, act on $_. Maybe we SHOULD include them?..
    'iterator?', # obscure synonym of block_given?
    'pp', # that's not docs. Proper ones included manually.
  ]

  def self.call(method_docs)
    method_docs.keys.-(CONFIG.flat_map { _1[:methods] }).-(IGNORED_METHODS).then { |missing|
      warn "Missing Kernel methods in docs: #{missing.sort.join(', ') }" unless missing.empty?
    }
    CONFIG.reduce(+'') do |result, section: nil, methods:|
      result << "\n## #{section}\n\n" if section

      methods.inject(result) do |res, name|
        comment =
          method_docs.fetch(name) { fail "Kernel method #{_1} not documented"}
          # take just a first phrase of the markdown comment
          .then { RDOC_TO_MARKDOWN.convert(_1)[/\A(.*?([.;]\s|\z))/m, 1].strip.tr("\n", ' ') }
        title = name

        # Kinda "sanitization" state, but easier to do it here...
        case name
        when 'exec'
          comment.sub!(/(?<=the given external \*command\*).+$/, '.')
        when 'caller'
          comment.sub!("in `method'", "in 'method'")
        when 'Complex'
          comment.sub!('x+i*y', '`x+i*y`')
        when /__(.+)__/
          title = "\\_\\_#{$1}\\_\\_"
        when '`'
          title = '\\`'
        end

        res << "* [#{title}](ref:Kernel##{name}): #{comment}\n"
      end
    end
  end
end