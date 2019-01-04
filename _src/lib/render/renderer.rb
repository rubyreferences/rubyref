require_relative 'linker'

class Renderer < Kramdown::Converter::Kramdown
  # Kramdown does spaces, we want GFM-style ```
  def convert_codeblock(el, opts)
    "\n```#{code_lang(el.value)}\n#{el.value}```\n"
  end

  def convert_header(el, opts)
    # Jekyll will generate them later, but with the same Kramdown logic, so it is safe to
    # insert links-to-self now.
    id = generate_id(el.options[:raw_text])

    super.sub(/\n\z/, "[](##{id})\n")
  end

  def convert_a(el, opts)
    linker.call(el, opts)
  end

  def code_lang(str)
    case
    when !Ripper.sexp(str).nil? # If Ripper can't parse it, it is not Ruby (console output, or diagram, or whatever)
      'ruby'
    when str.match?(/^irb\(main\)/) # FIXME: fragile, only for `quickstart.md`
      'irb'
    end
  end

  memoize def linker
    Linker.new(self, **@options)
  end

end
