require "treetop"

module CSS
  prefix = File.join(File.dirname(__FILE__), 'lesstidy')

  require "#{prefix}/css_syntax"
  Treetop.load "#{prefix}/css"

  autoload :Nodes,     "#{prefix}/nodes"
  autoload :Renderer,  "#{prefix}/renderer"
  autoload :Style,     "#{prefix}/style"
end

# Document
#   Ruleset
#     Selector 
#     Rule
#     Mixin
#     Ruleset*
