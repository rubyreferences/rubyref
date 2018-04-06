#!/usr/bin/env ruby

require 'yaml'
known = File.read(File.expand_path('../config/structure.yml', __dir__)).scan(/source: "?(\S+\.md)/).flatten
Dir[File.expand_path('../intermediate/parsed/**/*.md', __dir__)].sort
  .map { |p| p.sub(%r{^.+intermediate/parsed/}, '') }
  .yield_self { |l| l - known }
  .map { |p| {'source' => p} }
  .tap { |l| puts l.to_yaml }