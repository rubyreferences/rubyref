module Renderers
  module TOC
    META = {
      ruby_version: BOOK_RUBY_VERSION
    }

    extend self

    def call(structure)
      structure.top_chapters.map(&method(:chapter))
        .then { META.merge(chapters: _1) }
        .then { Hm(_1).transform_keys(&:to_s).to_h }

    end

    private

    def chapter(chap)
      {
        title: chap.title,
        path: chap.html_path,
        children: (chap.children.map(&method(:chapter)) unless chap.children.empty?)
      }.compact
    end
  end
end