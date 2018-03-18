require 'pp'
require 'kramdown'
require 'yaml'
require 'fileutils'

def sanitize_line(source, ln)
  return ln if ln.start_with?('    ') # It's code, don't touch it!

  ln
    .gsub(/(?<=[^`])([A-Z][a-zA-Z:]+[#][a-z_?!\[\]=]+)(?=[^`a-z_?!=\[\]]|$)/, '`\1`') # FooBar#foobar, always method reference
    .gsub(/(?<= |^)([#][a-z_?!\[\]=]+)(?=[^`a-z_?!=\[\]]|$)/, '`\1`') # #foobar, always method reference
    .gsub(/(?<=[^`])(__[A-Z_]+__)(?=[^`])/, '`\1`')
    .gsub(/(?<=[a-z])`(?=[a-z])/, "'") # Fancy apostrophe for typesetting
end

Dir['intermediate/parsed/**/*.md'].each do |source|
  target = source.sub('/parsed/', '/sanitized/')
  content = File.read(source)
    .sub(/\A\#\s*-\*-[^\n]+\n/, '') # First line with settings to editor
    .strip
    .gsub("ruby-talk:69518\n:   ", "[ruby-talk:69518] ") # Just broken by rdoc2markdown
    .gsub(/\n(.+)\n: {3}(?=\S)/, "\n* \\1: ") # RDoc converts dd/dt this way, no Markdown corresponding syntax...
    .gsub(/`([^\n`']+?)'/, '`\1`') # Code pieces wrapped in `foo'
    .gsub("`(?``*name*`')`", "`(?'`*name*`')`") # Manually fix one case broken by previous line
    .gsub("`enor'", "'enor'") # And another one...
    .gsub(/(\n[^\*].+)\n(\* )/, "\\1\n\n\\2") # List start without empty space after previous paragraph
    .split("\n").map { |ln| sanitize_line(source, ln) }
    .join("\n")

  # Per file fixes:
  case source
  when %r{doc/keywords\.md}
    # TODO: Or maybe fancy table?
    content = content
      .gsub(/\n\* (\S+):/, "\n* `\\1`:")
  when %r{doc/globals\.md}
    # TODO: Or maybe fancy table?
    content = content
      .gsub(/\n\* (\S+):/, "\n* `\\1`:")
      .gsub(/(?<=to the |to )(\$.)/, '`\1`')
  end

  FileUtils.mkdir_p File.dirname(target)
  File.write target, content
end