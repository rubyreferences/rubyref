require 'kramdown'
require 'pp'
require 'redcarpet'

TEXT = %q{Prints 1, 2 and 3.

Like `while` and `until`, the `do` is optional.

The `for` loop is similar to using `#each`, but does not create a new variable
scope.
}

doc = Kramdown::Document.new(TEXT)

pp doc.root.children
# pp doc.root.children[3].instance_variables.map { |iv| [iv, doc.root.children[3].instance_variable_get(iv)] }.to_h
# p content
# doc.root.children.replace(content)

class GFMKonverter < Kramdown::Converter::Kramdown
  def convert_codeblock(el, opts)
    "\n```ruby\n#{el.value}```\n"
  end
end

doc.root.children.first.options[:encoding] = 'UTF-8'
puts GFMKonverter.convert(doc.root.children.first)
# puts GFMKonverter.convert(doc.root)
