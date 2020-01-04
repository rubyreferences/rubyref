require 'ripper'
require_relative 'linker'

class CustomKramdownRenderer < Kramdown::Converter::Kramdown
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
    inner_text = inner(el, opts)
    href = Linker.call(el.attr['href']) or return inner_text

    if href.match?(/^https?:/)
      cls = href.match(%r{^https?://ruby-doc\.org}) ? "ruby-doc remote" : "remote"
      "<a href='#{href}' class='#{cls}' target='_blank'>#{inner_text}</a>"
    else
      "[#{inner_text}](#{href})"
    end
  end

  def code_lang(str)
    case
    when !Ripper.sexp(str).nil? # If Ripper can't parse it, it is not Ruby (console output, or diagram, or whatever)
      'ruby'
    when str.match?(/^irb\(main\)/) # FIXME: fragile, only for `quickstart.md`
      'irb'
    end
  end
end
