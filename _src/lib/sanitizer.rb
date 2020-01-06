module Sanitizer
  extend self

  # Sanitizing of Markdown converted from RDoc of ruby repo
  def from_repo(path, source)
    source
      .sub(/\A\#\s*-\*-[^\n]+\n/, '') # First line with settings to editor
      .strip
      .gsub("ruby-talk:69518\n:   ", "[ruby-talk:69518] ")    # Just broken by rdoc2markdown
      .gsub(/\n(.+)\n: {3}(?=\S)/, "\n* \\1: ")               # RDoc converts dd/dt this way, no Markdown corresponding syntax...
      .gsub(/`(\w[^\n`']*?)'/, '`\1`')                        # Code pieces wrapped in `foo'
      .gsub("`(?``*name*`')`", "`(?'`*name*`')`")             # Manually fix one case broken by previous line
      .gsub("`enor'", "'enor'")                               # And another one...
      .gsub(/(\n[^\*\n][^\n]+)\n(\* )/, "\\1\n\n\\2")         # List start without empty space after previous paragraph
      .gsub(/(\[RFC\d+\])\s+(?=\(http)/, '\1')                # Remove wrongful spaces in [RFCxxxx] (http://) for Net:: libs
      .split("\n").map(&method(:line))
      .join("\n")
      .then { per_repo_file(path, _1) }
  end

  # Sanitizing of Markdown from ruby-lang.org repository
  def from_site(path, source)
    source
      .sub(/\A---\n.+?\n---\n/m, '')  # YAML frontmatter
      .gsub(/\{:.+?\}/, '')           # {: .foo} tags
      .gsub(/\{% highlight (sh|ruby|c) %\}\n.+?\n\{% endhighlight %\}/m) { |str|
        # Shell commands, Ruby code of "old" Jekyll syntax → to just space-formatted
        str.gsub(/\{%.+?%\}/, '').gsub(/^/, '    ')
      }
      .gsub(/\{% highlight irb %\}\n.+?\n\{% endhighlight %\}/m) { |str|
        # In one place IRB code is too close to the list above, and indent-formatted
        # code gets broken.
        #
        # "^"" is Kramdown's end-of-block marker (to say "the list is ended, this indent
        # is NOT continuation of it")
        # https://kramdown.gettalong.org/syntax.html#eob-marker
        str.gsub(/\{%.+?%\}/, '').gsub(/^/, '    ').prepend("\n^\n")
      }
      .then { per_site_file(path, _1) }
  end

  private

  def line(ln)
    return ln if ln.start_with?('    ') # It's code, don't touch it!

    ln
      .gsub(/(?<=[^`])([A-Z][a-zA-Z:]+[#][a-z_?!\[\]=]+)(?=[^`a-z_?!=\[\]]|$)/, '`\1`')   # FooBar#foobar, always method reference
      .gsub(/(?<= |^)([#][a-z_?!\[\]=]+)(?=[^`a-z_?!=\[\]]|$)/, '`\1`')                   # #foobar, always method reference
      .gsub(/(?<=[^`])(__[A-Z_]+__)(?=[^`])/, '`\1`')
      .gsub(/(?<=[a-z])`(?=[a-z])/, "'")                                                  # Fancy apostrophe for typesetting
      .gsub('---', '—')                                                                   # Just dash. Probably should be done smarter
  end

  def per_repo_file(path, content)
    case path
    when 'doc/keywords.md'
      # TODO: Or maybe fancy table?
      content
        .gsub(/\n\* (\S+):/, "\n* `\\1`:")
    when 'doc/globals.md'
      # TODO: Or maybe fancy table?
      content
        .gsub(/\n\* (\S+):/, "\n* `\\1`:")
        .gsub(/(?<=to the |to )(\$.)/, '`\1`')
        .sub('`$s`tderr', '`$stderr`')
        .sub('`$``') { '<code class="highlighter-rouge">$`</code>' } # Without block, '`' has special meaning in sub
        .gsub(/(?<!`)\$(stdin|stdout|DEBUG|VERBOSE)/, '`$\1`')
    when 'core/Class.md'
      content.sub('of the class `Class`.', "of the class `Class`.\n") # To properly render the diagram after
    when 'core/Float.md'
      content.sub("wiki-floats_i\n    mprecise\n\n", "wiki-floats_imprecise\n")
    when 'lib/cgi/CGI.md'
      content.sub("[cgi]('field_name')", "`cgi['field_name']`")
    when 'lib/irb/IRB.md'
      content.sub('[IRB.conf](:IRB_RC)', '`IRB.conf[:IRB_RC]`')
    when 'lib/prime/Prime.md'
      content
        .sub("e.g.\n    Prime", "e.g.\n\n    Prime")
        .sub('`Prime`.instance', '`Prime.instance`')
        .gsub('`Prime`::`', '`Prime::')
    when 'core/String\.md'
      content
        .gsub("``!''", "`!`")
    when %r{ext/date/}
      content.sub(/\A.+?\n/, '') # We don't need first header inserted by render script.
    when 'core/MatchData.md'
      # Somebody have broken links to different parts of Regex:
      # https://ruby-doc.org/core-2.7.0/MatchData.html#class-MatchData-label-Global+variables+equivalence
      content
        .sub('Regexp.last_match;', '`Regexp.last_match`;')
        .sub('[Regexp.last_match](0)', '`Regexp.last_match[0]`')
        .sub('[Regexp.last_match](i)', '`Regexp.last_match[i]`')
        .sub('Regexp.last_match`.pre_match`', '`Regexp.last_match.pre_match`')
        .sub('Regexp.last_match`.post_match`', '`Regexp.last_match.post_match`')
        .sub('[Regexp.last_match](-1)', '`Regexp.last_match[-1]`')

    # FIXME: probably could be handled generically (line with a lot of spaces after line without spaces):
    when 'lib/abbrev/Abbrev.md'
      content.gsub("*Generates:*\n", "*Generates:*\n\n")
    when 'lib/logger/Logger.md'
      content.gsub(/(Log (format|sample)):\n/, "\\1\n\n")
    when 'lib/pp/PP.md'
      content.gsub("returns this:\n", "returns this:\n\n")
    when 'lib/optparse/OptionParser.md'
      content.gsub(/((Used|output):)\n(?=    bash-3\.2)/, "\\1\n\n")
    when 'lib/English/English.md'
      content.gsub(/^\* (\$.+?): (\$.+?)$/, '* `\1`: `\2`')
        .sub('`$``') { '<code class="highlighter-rouge">$`</code>' } # Without block, '`' has special meaning in sub

      # TODO:
    # when %r{_special/kernel\.md}
    #   content.gsub(/ref:\`(.+?)\`/, 'ref:\1')
    else
      content
    end
  end

  def per_site_file(path, content)
    case path
    when 'ruby-lang.org/en/documentation/installation/index.md'
      content.sub(/\* \[Package Management Systems.+\(\#building-from-source\)/m, '')
    else
      content
    end
  end
end