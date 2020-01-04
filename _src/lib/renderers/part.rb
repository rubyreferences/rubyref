require_relative 'operations'
require_relative 'linker'
require_relative 'custom_kramdown_renderer'

module Renderers
  class Part
    def self.call(chapter, definition)
      new(chapter, definition).call
    end

    attr_reader :chapter, :definition

    def initialize(chapter, definition)
      @chapter = chapter
      @definition = definition
      @operations = Operations.build_for(self)
    end

    def call
      return '' if definition.ignore?

      read_source
        .then { preprocess(_1) }
        .then { Kramdown::Document.new(_1).root.children }
        .then { @operations.reduce(_1) { |res, op| op.call(res) } }
        .then { shift_headers(_1) }
        .then { render(_1) }
        .then { postprocess(_1) }
    rescue => e
      fail "#{e.message} while rendering #{@definition.path} for #{@chapter.out_path}"
    end

    private

    def read_source
      definition.literal? ? definition.source : File.read(definition.ready_path)
    end

    def preprocess(source)
      Array(@definition.replace).inject(source) { |src, from:, to:| src.gsub(from, to) }
    end

    def shift_headers(elements)
      shift =
        case
        when definition.header_shift then definition.header_shift.to_i
        when definition.literal? then 0 # do not shift headers of verbatim
        # Top good-looking header is ##, all other should be deeper
        when chapter.parts.index(definition).zero? then 1
        else 2
        end

      elements.each { _1.options[:level] += shift if _1.type == :header }
    end

    def render(elements)
      root = Kramdown::Element.new(:root)
      root.options[:encoding] = 'UTF-8'
      root.children = elements
      CustomKramdownRenderer.convert(root).first
    end

    def postprocess(markdown)
      markdown
        .gsub(/^(?=\#[a-z])/, '\\')       # Again! New methods could be at the beginning of the line after Kramdown render
        .gsub(/([`'])\\:\s/, '\1: ')      # IDK why Kramdown turns "`something`: definition" into "`something`\: definition", but Jekyll becomes unhappy
        .gsub_r(/(https?:\S+)\\_/, '\1_') # Kramdown helpfully screens _ in URLs... And then GitBook screens them again.
        .gsub(/\[.+?\]\(\/.+?\)/, &method(:fix_relative_link))
    end

    def fix_relative_link(text)
      # TODO: fix it
      # TODO: we had "link validation" service earlier...
      text
    end
  end
end