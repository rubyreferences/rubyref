require 'yaml'
known = File.read('config/structure.yml').scan(/source: (\S+\.md)/).flatten
Dir['intermediate/parsed/**/*.md'].sort
  .map { |p| p.sub('intermediate/parsed/', '') }
  .yield_self { |l| l - known }
  .map { |p| {'source' => p} }
  .tap { |l| File.write 'intermediate/list.yml', l.to_yaml }