require "treetop"

module Lesstidy
  prefix = File.join(File.dirname(__FILE__), 'lesstidy')

  Treetop.load "#{prefix}/grammar/less.treetop"

  autoload :Nodes,       "#{prefix}/nodes"
  autoload :Renderer,    "#{prefix}/renderer"
  autoload :Document,    "#{prefix}/document"
  autoload :Style,       "#{prefix}/style"
  autoload :CUtil,       "#{prefix}/cutil"
  autoload :Preset,      "#{prefix}/preset"
  autoload :Config,      "#{prefix}/config"
  autoload :StyleParser, "#{prefix}/style_parser"

  Error = Class.new(::StandardError)
  PresetNotFoundError = Class.new(Error)
  ParseError          = Class.new(Error)
end
