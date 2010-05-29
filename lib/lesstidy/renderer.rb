require 'ostruct'

module Lesstidy
  module Renderer
    # args = new Args(*args)
    # args.context
    class Args < OpenStruct
      def new(*args)
        super args.inject({}) { |a, i| a.merge! i }
      end
    end

    def to_css(*args)
      # Try to delegate to `(classname)_to_css` (eg, rule_to_css).
      klass = /([a-zA-Z_]+)$/.match(self.class.to_s)[1]
      css_method = "#{klass}_to_css".downcase.to_sym
      if respond_to? css_method
        send css_method, *args
      else
        ''
      end
    end

    protected
    def document_to_css(style = Style.new, *args)
      @elements.inject('') do |a, element|
        a << element.to_css(style, :context => :document); a
      end
    end

    def comment_to_css(style, *args)
      args = Args.new *args
      args.depth ||= 0

      if args.context == :document
        style.document_comment % ["/* #{@comment} */"]

      elsif args.context == :ruleset
        indent  = ' ' * (args.depth * style.subrule_indent)
        comment = "/* #{@comment} */" 
        "#{indent}#{comment}\n"
      end
    end

    def ruleset_to_css(style, *args)
      args = Args.new *args
      args.depth ||= 0

      selectors = @elements.select { |e| e.is_a? Nodes::Selector }
      items     = @elements.select { |e| e.is_a? Nodes::Mixin or e.is_a? Nodes::Rule }
      rnc       = @elements.select { |e| e.is_a? Nodes::Ruleset or e.is_a? Nodes::Comment }

      # Start: selectors
      r = ''
      r << selectors_to_css(selectors, style, args)

      # Items (properties, mixins, etc)
      indent = r.split("\n")[-1].size
      r << items_to_css(items, indent, style, args)

      # Subrules and Comments (rnc)
      r << rules_and_comments_to_css(rnc, style, args)

      # Close brace
      indent = args.depth * style.subrule_indent # Number of spaces
      r << (' ' * indent)  if /\n$/.match(r)
      r << style.close_brace
    end

    def rule_to_css(style, *args)
      # TODO: Property width
      @property + style.colon + @value
    end

    def mixin_to_css(style, *args)
      if @params
        "%s(%s)" % [@selector, @params]
      else
        @selector
      end
    end

    def selector_to_css(style, *args)
      @selector.strip.squeeze(' ')
    end

    # Gets the rendered string for a given set of Selectors
    # Delegate method of ruleset_to_css
    def selectors_to_css(sels, style, args)
      indent        = args.depth * style.subrule_indent # Number of spaces
      indent_str    = ' ' * indent
      selector_strs = sels.map { |sel| sel.to_css(style) }

      r = CUtil::String.new
      r.replace    selector_strs.join(style.comma)
      r.prepend!   indent_str
      r.wrap!      :width     => style.selector_width,
                   :pad       => true,
                   :no_rewrap => (!style.selector_wrap),
                   :indent    => indent  unless style.selector_width.nil?
      r.append!    style.open_brace
      r.to_s
    end

    # Gets the rendered string for a given set of Mixins and Rules (what's inside {}'s)
    # Delegate method of ruleset_to_css
    def items_to_css(items, indent, style, args)
      items_css = items.map { |item| item.to_css(style) + style.semicolon }

      indent_value = style.property_indent

      if style.selector_width.nil? # Not column mode?
        indent_value += style.subrule_indent * (args.depth)
      else
        indent_value += style.selector_width
      end

      r = CUtil::String.new
      r.replace  items_css.join('')
      r.wrap!    :width        => style.wrap_width,
                 :indent       => indent_value, 
                 :first_indent => indent  unless style.wrap_width.nil?
      r.gsub!    /^/, ' ' * indent_value  if style.wrap_width.nil? and /\{.*\n.*$/.match(style.open_brace)
      r.to_s
    end

    # Gets the rendered string for a given set of Rules and Comments
    # Delegate method of ruleset_to_css
    def rules_and_comments_to_css(items, style, args)
      r = ''
      if items.size > 0
        item_strs = items.map do |item|
          item.to_css(style,
                      :context => :ruleset,
                      :depth   => (args.depth + 1))
        end
        r << style.subrule_before
        r << item_strs.join('')
      end

      # Remove trailing \n's
      r.gsub! /\n+$/, "\n"
      r
    end

  end
end
