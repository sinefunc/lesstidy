module Lesstidy
  module Nodes
    class Node
      include Lesstidy::Renderer

      attr_reader :elements
      attr_accessor :parent

      def initialize(*a)
        @elements = []
        @parent = nil
      end

      def <<(element)
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
        "[ruleset]"
      end
    end

    class Comment < Node
      attr_reader :comment

      def initialize(content)
        super
        @comment = content
      end

      def inspect_s
        "/* #{@comment} */"
      end
    end

    class Selector < Node
      attr_reader :selector

      def initialize(selector)
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
        "[R]    #{@property}: #{value}"
      end
    end

    class Mixin < Node
      attr_reader :selector
      attr_reader :params

      def initialize(selector, params = nil)
        super
        @selector = selector
        @params = params
      end

      def inspect_s
        "[M]    #{@selector}%s" % [(params ? "(#{params})" : '')]
      end
    end
  end
end
