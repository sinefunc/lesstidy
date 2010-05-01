require "treetop"

module CSS
  prefix = File.join(File.dirname(__FILE__), 'lesstidy')

  require "#{prefix}/css_syntax"
  Treetop.load "#{prefix}/css"

  autoload :Nodes,     "#{prefix}/nodes"
  autoload :Style,     "#{prefix}/style"
end
