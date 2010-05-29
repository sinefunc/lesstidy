require "../lib/lesstidy"

def t( a )
  CSSParser.new.parse a
end

def try( a )
  style = Lesstidy::Style.new

  p = CSSParser.new.parse a
  puts (p.nil? ? '[FAIL]' : '[ OK ]') + " #{a}"
  
  if p.respond_to? :build
    node = p.build
    puts node.inspect
    puts node.to_css style
  end
  
  puts ""
end

#try ""
#try "div { color: red; }"
#try "div{color:red;}"
#try "div,div { color: red; }"
#try "div,div { .lol(); color: red; }"
#try "div,div { color: red; font-weight: bold; }"
#try "div,div { color: red; font-weight: bold; a { color: red; } }"
#try "#menu a,div { color: red; font-weight: bold; } #menu ul li > div, td, tr, #menu a:hover div #lol yes yes .something span.clear-fix, table { text-align: center; .black; font-weight: bold; border: solid 2px #882828; cursor: default; background-repeat: no-repeat; } a:hover { .corner(5px); background: url(foo.png); span { font-weight: bold; } span, a:hover, a:active, a:hover span, a:active span { text-decoration: underline; strong em { color: blue; } } }"
try File.open('fixtures/test-2.control.css') { |f| f.read }

