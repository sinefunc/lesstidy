require "../lib/lesstidy"

def t( a )
  CSSParser.new.parse a
end

def try( a )
  style = CSS::Style.new

  p = CSSParser.new.parse a
  puts (p.nil? ? '[FAIL]' : '[ OK ]') + " #{a}"
  
  if p.respond_to? :build
    node = p.build
    puts node.inspect
    puts node.to_css style
  end
  
  puts ""
end

try ""
try "div { color: red; }"
try "div{color:red;}"
try "div,div { color: red; }"
try "div,div { .lol(); color: red; }"
try "div,div { color: red; font-weight: bold; }"
try "div,div { color: red; font-weight: bold; a { color: red; } }"
try "#menu a,div { color: red; font-weight: bold; } #menu ul li > div, #menu a:hover span.clear-fix, td, tr, table { text-align: center; .black; font-weight: bold; border: solid 2px #882828; cursor: default; background-repeat: no-repeat; } a:hover { .corner(5px); background: url(foo.png); span { font-weight: bold; } }"

def a
  #t "div,div { color: red; font-weight: bold; /* wtf */ }"
  t "/*LOL*/div,strong{color:red;font-weight:bold;}p,blockquote{display:block;}"
end

