#!/usr/bin/env ruby
require 'kramdown'

sources = Dir[File.expand_path('../../{,**/}*.md', __dir__)].grep_v(/_src/).sort
sources.each do |path|
  doc = Kramdown::Document.new(File.read(path), input: 'GFM')
  headers = doc.root.children.select { |c| c.type == :header }
  headers.first.options
    .then { |level:, raw_text:, **|
        level == 2 or puts "First header should be level 2, #{level} found: #{path} - #{raw_text}"
    }

  headers.map(&:options).each_cons(2) {|h1, h2|
    l1, t1 = h1.values_at(:level, :raw_text)
    l2, t2 = h2.values_at(:level, :raw_text)
    l2 <= l1 + 1 or
      puts %{#{path}: "#{'#' * l1} #{t1}" > #{'#' * l2} #{t2}}
  }
end