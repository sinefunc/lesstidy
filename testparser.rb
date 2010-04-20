require "lib/lesstidy"

def t( a )
  CSSParser.new.parse a
end

def try( a )
  p = CSSParser.new.parse a
  puts (p.nil? ? '[FAIL]' : '[ OK ]') + " #{a}"
  puts p.lol if p.respond_to? :lol
  puts ""
end

try ""
try "div { color: red; }"
try "div{color:red;}"
try "div,div { color: red; }"
try "div,div { .lol(); color: red; }"
try "div,div { color: red; font-weight: bold; }"
try "div,div { color: red; font-weight: bold; /* wtf */ }"

def a
  #t "div,div { color: red; font-weight: bold; /* wtf */ }"
  t "/*LOL*/div,strong{color:red;font-weight:bold;}p,blockquote{display:block;}"
end

