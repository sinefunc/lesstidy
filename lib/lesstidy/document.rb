module CSS
  class Document < CSS::Nodes::Document
    def initialize(str)
      super
      tree = CSSParser.new.parse(str)
      tree.build self
    end
  end
end
