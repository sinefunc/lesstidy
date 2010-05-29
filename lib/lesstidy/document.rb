module Lesstidy
  class Document < Lesstidy::Nodes::Document
    def initialize(str)
      super
      parser = LessParser.new
      tree = parser.parse(str)
      tree.build self
    end
    
    def self.load(filename)
      str = File.open(filename) { |f| f.read }
      return self.new(str)
    end
  end
end
