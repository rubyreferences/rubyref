module Renderers
  module Operations
    STDLIB = <<~DOC
      _Part of standard library. You need to `require '%s'` before using._

    DOC
    REQ_STDLIB = "    require '%s'\n\n"
    SINCE_RUBY_VER = "<div class='since-version'>Since Ruby %s</div>\n\n"
    SINCE_RUBY_VER_C = "<div class='since-version'>Since Ruby %s <i>(%s)</i></div>\n\n"

    def self.build_for(owner)
      {
        sections: SelectSections,
        process: CallHandlers,
        remove_sections: RemoveSections,
        remove: RemoveParagraphs,
        insert: InsertParagraphs
      }.filter_map { |key, klass|
        Array(owner.definition.send(key)).then { klass.new(owner, _1) unless _1.empty? }
      }
    end

    class Base < Struct.new(:owner, :data)
      def inspect
        "#<#{self.class}(#{data})>"
      end

      private

      def para_idx(elements, what)
        elements.find_index { to_md(_1).start_with?(what) } or
            fail "Paragraph containing #{what.inspect} not found"
      end

      def from_md(text)
        Kramdown::Document.new(text).root.children
      end

      def to_md(el)
        el.options[:encoding] = 'UTF-8'
        Kramdown::Converter::Kramdown.convert(el, line_width: 1000).first
      end
    end

    class SelectSections < Base
      def call(elements)
        data.flat_map { |section|
          if section == '_ref' # special syntax to borrow the "[ClassName Reference](...)" link
            elements
              .select { to_md(_1).match(/^\[\S+ Reference\]/) }
              .tap { |ref| ref.empty? and fail "Reference not found!" }
          else
            elements
              .drop_while { _1.type != :header || _1.options[:raw_text] != section }
              .tap { _1.empty? and fail "Section #{section} not found!" }
              .take_while { _1.type != :header || _1.options[:raw_text] == section }
          end
        }
      end
    end

    class CallHandlers < Base
      def call(elements)
        data.inject(elements) do |els, (what, *arg)|
          send("handle_#{what}", els, *arg)
        end
      end

      def handle_stdlib(elements, libname)
        para_idx(elements, '#') # First header
          .then { |idx| elements[..idx] + from_md(STDLIB % libname) + elements[idx + 1..] }
      end

      def handle_require_stdlib(elements, libname = nil)
        libname ||= owner.definition.lib_name or fail "Can't guess libname by #{owner.definition}"

        from_md(REQ_STDLIB % libname) + elements
      end
    end

    class RemoveSections < Base
      def call(elements)
        data.inject(elements) { |els, section|
          before = els.take_while { _1.type != :header || _1.options[:raw_text] != section }
          els = els[before.size..-1]
          els.empty? and fail "Section #{section} not found"
          inside = els.take_while { _1.type != :header || _1.options[:raw_text] == section }
          after = els[inside.size..-1]

          # For example, we want to drop last section (# Contribution), but preserve [Docs Reference] after it
          if reference = inside.detect { to_md(_1).match(/^\[\S+ Reference\]/) }
            before.push(reference)
          end

          before + after
        }
      end
    end

    class RemoveParagraphs < Base
      def call(elements)
        data.inject(elements) { |els, rem|
          para_idx(els, rem).then { els[..._1] + els[_1 + 1..] }
        }
      end
    end

    class InsertParagraphs < Base
      def call(elements)
        data.map { _1.transform_keys(&:to_sym) }.inject(elements) do |els, opts|
          idx = para_idx(els, opts.fetch(:after))
          source = opts[:source] || opts[:macros]&.then(&method(:process_macros)) or
            fail "source or macros is required for insert"
          source = File.read(source) if File.exist?(source)

          els[..idx] + from_md(source) + els[idx + 1..]
        end
      end

      private

      def process_macros(text)
        m = text.match(/^(\w+)\((.+)\)$/) or fail ArgumentError, "Unparseable macros #{text}"
        send("macro_#{m[1]}", m[2].split(/\s*,\s*/))
      end

      def macro_since(ver, clarification = nil)
        if clarification
          SINCE_RUBY_VER_C % [ver, clarification]
        else
          SINCE_RUBY_VER % ver
        end
      end
    end
  end
end