require 'kramdown'
require 'pp'
require 'redcarpet'

TEXT = %q{
\#unshift is pretty cool in fact
}

doc = Kramdown::Document.new(TEXT)

# pp doc.root.children[1].type
# pp doc.root.children.last(2)

class GFMKonverter < Kramdown::Converter::Kramdown
  def convert_codeblock(el, opts)
    "\n```ruby\n#{el.value}```\n"
  end
end

puts GFMKonverter.convert(doc.root)
