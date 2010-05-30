module Lesstidy
  class Document < Lesstidy::Nodes::Document
    def initialize(str)
      super
      parser = LessParser.new
      tree = parser.parse(str)

      if tree
        tree.build self
      else
        raise Lesstidy::ParseError, parser.failure_message
      end
    end
    
    def self.load(filename)
      str = File.open(filename) { |f| f.read }
      return self.new(str)
    end
  end
end
