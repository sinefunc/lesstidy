module CSS
  class Document < CSS::Nodes::Document
    def initialize(str)
      super
      tree = CSSParser.new.parse(str)
      tree.build self
    end
    
    def self.load(filename)
      str = File.open(filename) { |f| f.read }
      return self.new(str)
    end
  end
end
