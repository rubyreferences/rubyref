require 'kramdown'

require_relative 'part'

module Renderers
  class Chapter
    def self.call(definition)
      new(definition).call
    end

    def initialize(definition)
      @definition = definition
    end

    def call
      "#{front_matter.to_yaml}---\n\n" +
        @definition.parts.map{ Renderers::Part.call(@definition, _1) }.join("\n\n")
    end

    def front_matter
      {
        title: @definition.title,
        prev: @definition.prev_chapter&.html_path,
        next: @definition.next_chapter&.html_path,
        permalink: ('/' if @definition.out_path == '../README.md') # :shrug:
      }.compact.transform_keys(&:to_s)
    end
  end
end