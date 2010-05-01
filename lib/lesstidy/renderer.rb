module CSS
  module Renderer
    def to_css(*a)
      # Try to delegate to `(classname)_to_css` (eg, rule_to_css).
      klass = /([a-zA-Z_]+)$/.match(self.class.to_s)[1]
      css_method = "#{klass}_to_css".downcase.to_sym
      if respond_to? css_method
        send css_method, *a
      else
        ''
      end
    end

    def document_to_css(style)
      @elements.inject('') { |a, e|
        if e.is_a? Nodes::Ruleset
          a << e.to_css(style, 0)
        end
        a
      }
    end

    def ruleset_to_css(style, depth = 0)
      selectors = @elements.select { |e| e.is_a? Nodes::Selector }
      items     = @elements.reject { |e| e.is_a? Nodes::Selector or e.is_a? Nodes::Ruleset }
      subrules  = @elements.select { |e| e.is_a? Nodes::Ruleset }

      # Selector
      sels = selectors.map { |sel| sel.to_css(style) }
      sels = sels.join(style.comma)
      if style.selector_width
        sels = wrap(sels, style.selector_width, :pad => true)
      end
      ret = sels + style.open_brace

      # Items (properties, mixins, etc)
      indent = ret.split("\n")[-1].size
      items = items.map { |item| item.to_css(style) + style.semicolon }.join('')
      items = wrap(items, style.wrap_width, :indent => style.property_indent, :first_indent => indent)
      ret = ret + items

      # End
      ret = ret + style.close_brace
      ret
    end

    def rule_to_css(style)
      # TODO: Property width
      @property + style.colon + @value
    end

    def mixin_to_css(style)
      @selector
    end

    def selector_to_css(style)
      @selector.strip
    end

    protected
    def wrap(text, width, *a)
      options = a.inject({}) { |a, i| a.merge! i }

      first_indent = options[:first_indent]
      indent = ''
      indent = ' ' * options[:indent]  if options[:indent]

      ret = text.split(/(?<=[, ])/).inject(['']) do |a, chunk|
        nl = a[-1] + chunk

        if (not first_indent and nl.rstrip.size > width) or \
          (first_indent and nl.rstrip.size > (width - first_indent))
          # To wrap...
          a << (indent + chunk)
          first_indent = false
        else
          # Or not to wrap
          a[-1] = nl
        end
        a
      end

      # Pad the last line with spaces
      ret[-1] = ret[-1] + (" " * (width - ret[-1].size))  if options[:pad]

      # Stringify if needde
      options[:array] ? ret : ret.join("\n")
    end
  end
end
