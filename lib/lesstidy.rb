require "treetop"

module CSS
  prefix = File.join(File.dirname(__FILE__), 'lesstidy')

  require "#{prefix}/css_syntax"
  Treetop.load "#{prefix}/css"

  autoload :Nodes,     "#{prefix}/nodes"
  autoload :Renderer,  "#{prefix}/renderer"
  autoload :Document,  "#{prefix}/document"
  autoload :Style,     "#{prefix}/style"
  autoload :CUtil,     "#{prefix}/cutil"
end
