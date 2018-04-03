txt = <<~TXT
Additionally, you cannot alter the precedence of the
operators.

`+`
:   add
`-`
:   subtract
`*`
:   multiply
TXT

txt = txt
    .gsub(/\n(.+)\n: {3}(?=\S)/, "\n* \\1: ") # RDoc converts dd/dt this way, no Markdown corresponding syntax...
    .gsub(/`([^\n`']+?)'/, '`\1`') # Code pieces wrapped in `foo'
    .gsub("`(?``*name*`')`", "`(?'`*name*`')`") # Manually fix one case broken by previous line
    .gsub("`enor'", "'enor'") # And another one...
    .gsub(/(\n[^\*\n][^\n]+)\n(\* )/, "\\1\n\n\\2") # List start without empty space after previous paragraph
puts txt