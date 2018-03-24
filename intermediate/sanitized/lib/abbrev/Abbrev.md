# Abbrev

Calculates the set of unambiguous abbreviations for a given set of strings.

    require 'abbrev'
    require 'pp'

    pp Abbrev.abbrev(['ruby'])
    #=>  {"ruby"=>"ruby", "rub"=>"ruby", "ru"=>"ruby", "r"=>"ruby"}

    pp Abbrev.abbrev(%w{ ruby rules })

*Generates:*

    { "ruby"  =>  "ruby",
      "rub"   =>  "ruby",
      "rules" =>  "rules",
      "rule"  =>  "rules",
      "rul"   =>  "rules" }

It also provides an array core extension, `Array#abbrev`.

    pp %w{ summer winter }.abbrev

*Generates:*

    { "summer"  => "summer",
      "summe"   => "summer",
      "summ"    => "summer",
      "sum"     => "summer",
      "su"      => "summer",
      "s"       => "summer",
      "winter"  => "winter",
      "winte"   => "winter",
      "wint"    => "winter",
      "win"     => "winter",
      "wi"      => "winter",
      "w"       => "winter" }

[Abbrev Reference](https://ruby-doc.org/stdlib-2.5.0/libdoc/abbrev/rdoc/Abbrev.html)