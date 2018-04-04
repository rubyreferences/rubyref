require_relative 'linker'

class Renderer < Kramdown::Converter::Kramdown
  # Kramdown does spaces, we want GFM-style ```
  def convert_codeblock(el, opts)
    "\n```#{code_lang(el.value)}\n#{el.value}```\n"
  end

  def code_lang(str)
    # If Ripper can't parse it, it is not Ruby (console output, or diagram, or whatever)
    Ripper.sexp(str).nil? ? '' : 'ruby'
  end

  def linker
    @linker ||= Linker.new(self, **@options)
  end

  def convert_a(el, opts)
    linker.call(el, opts)
  end
end
