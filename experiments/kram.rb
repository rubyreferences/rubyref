require 'kramdown'
require 'pp'
require 'redcarpet'

TEXT = %Q{
# H1

This is text.

## H2

* This is list.

      %i[a b c].each(&method(:puts))

## H3

This is paragraph.
}

doc = Kramdown::Document.new(TEXT)

pp doc.root.children[1].type
pp doc.root.children[1].options[:level] = 2

# class GFMKonverter < Kramdown::Converter::Kramdown
#   def convert_codeblock(el, opts)
#     "\n```ruby\n#{el.value}```\n"
#   end
# end

# puts GFMKonverter.convert(doc.root)
puts Kramdown::Converter::Kramdown.convert(doc.root)