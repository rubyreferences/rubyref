require 'kramdown'
require 'pp'
require 'redcarpet'

TEXT = %q{
One

# Two `and` **a half**

Three
}

doc = Kramdown::Document.new(TEXT)

# pp doc.root.children[1].type
# pp doc.root.children[3].instance_variables.map { |iv| [iv, doc.root.children[3].instance_variable_get(iv)] }.to_h
content = doc.root.children.dup
content = content.drop_while { |e| e.type != :header }
p content
doc.root.children.replace(content)

class GFMKonverter < Kramdown::Converter::Kramdown
  def convert_codeblock(el, opts)
    "\n```ruby\n#{el.value}```\n"
  end
end

puts GFMKonverter.convert(doc.root)
