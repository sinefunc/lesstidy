module CSSSyntax
  #class CSSNode < Treetop::Runtime::SyntaxNode
  #end

  module Document
  end

  module Ruleset
  end

  module Selector
  end

  module RuleNode 
  end

  module Comment
  end

  module Mixin
  end

  module Stylerule
  end
end

class Treetop::Runtime::SyntaxNode
  def cascade( env )
    elements.each { |e| e.build env if e.respond_to? :build }
    env
  end
end

module CSS
  class Node
    attr_reader :elements
    attr_accessor :parent
    def initialize( *a )
      @elements = []
      @parent = nil
    end
    def <<( element )
      @elements << element
      element.parent = self
    end
    def depth
      @parent.nil? ? 0 : (@parent.depth+1)
    end
    def inspect
      out = ""
      out << "\n" + (". " * (1+depth)) + self.inspect_s
      @elements.each { |e| out << e.inspect }
      out
    end

    def inspect_s
      "<#{self.class.to_s}>"
    end
  end

  class Document < Node
    def inspect_s
      "[document]"
    end
  end

  class Ruleset < Node
    def initialize( *args )
      super
    end

    def inspect_s
      "[rule]"
    end
  end

  class Comment < Node
    attr_reader :comment
    def initialize( content )
      super
      @comment = content
    end

    def inspect_s
      "/* #{@comment} */"
    end
  end

  class Selector < Node
    attr_reader :selector
    def initialize( selector )
      super
      @selector = selector
    end

    def inspect_s
      "[S] #{@selector}"
    end
  end

  class Rule < Node
    attr_reader :property
    attr_reader :value
    def initialize( property, value )
      super
      @property = property
      @value = value
    end
    
    def inspect_s
      "[R] #{@property}: #{value}"
    end
  end
end
