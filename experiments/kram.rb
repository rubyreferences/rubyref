require 'kramdown'
require 'pp'
require 'redcarpet'

TEXT = %q{Prints 1, 2 and 3.

Floating point has a different arithmetic and is an inexact number. So you
should know its esoteric system. See following:

*   http://docs.sun.com/source/806-3568/ncg_goldberg.html
*   http://wiki.github.com/rdp/ruby_tutorials_core/ruby-talk-faq#wiki-floats_imprecise
*   http://en.wikipedia.org/wiki/Floating_point#Accuracy_problems

}

doc = Kramdown::Document.new(TEXT)

# pp doc.root.children
# pp doc.root.children[3].instance_variables.map { |iv| [iv, doc.root.children[3].instance_variable_get(iv)] }.to_h
# p content
# doc.root.children.replace(content)

class GFMKonverter < Kramdown::Converter::Kramdown
  def convert_codeblock(el, opts)
    "\n```ruby\n#{el.value}```\n"
  end
end

class String
  def gsub_r(pattern, sub)
    res = gsub(pattern, sub)
    res == self ? res : res.gsub_r(pattern, sub)
  end
end

# doc.root.children.first.options[:encoding] = 'UTF-8'
puts GFMKonverter.convert(doc.root).first.gsub_r(/(https?:\S+?)\\_/, '\1_')
# puts GFMKonverter.convert(doc.root)
