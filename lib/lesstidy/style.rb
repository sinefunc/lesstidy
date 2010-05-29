require 'ostruct'

module Lesstidy
  class Style < OpenStruct
    def initialize(args = {})
     super defaults.merge(StyleParser.load_options(args))
    end
    
    def verify
      # wrap_width > selector_width
      # /\s*{\s/.match open_brace
    end

  protected
    def defaults
      { :wrap_width      => nil,    # nil for no wrap
        :selector_width  => nil,    # nil for no columning
        :open_brace      => " {\n",
        :close_brace     => "}\n\n",
        :document_comment => "\n%s\n",
        :semicolon       => ";\n",   # Add NLs after if needed
        :property_width  => nil,
        :colon           => ": ",   # Add spaces if needed
        :comma           => ", ",   # Spaces if needed
        :subrule_indent  => 2,      # Indentation of sub rules
        :subrule_before  => "\n",   # Separators of subrules
        :property_indent => 2,      # How much to indent properties on their next line (will take selector width into account)
        :selector_wrap   => false,  # Wrap long selectors?
      }
    end
  end
end
