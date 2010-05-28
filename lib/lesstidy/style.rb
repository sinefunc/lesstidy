require 'ostruct'

module CSS
  class Style < OpenStruct
    def initialize(custom = {})
      super custom
      defaults.each_pair { |k, v| @table[k.to_sym] ||= v }
    end
    
    def verify
      # wrap_width > selector_width
      # /\s*{\s/.match open_brace
    end

    # Convert to command line options
    def serialize
      ""
    end

    protected
    def defaults
      { :wrap_width      => 110,    # nil for no wrap
        :selector_width  => 40,     # nil for no columning
        :open_brace      => "{ ",
        :close_brace     => "}\n",
        :document_comment => "\n%s\n",
        :semicolon       => "; ",   # Add NLs after if needed
        :property_width  => nil,
        :colon           => ": ",   # Add spaces if needed
        :comma           => ", ",   # Spaces if needed
        :subrule_indent  => 2,      # Indentation of sub rules
        :subrule_before  => "\n",   # Separators of subrules
        :property_indent => 2,      # How much to indent properties on their next line (will take selector width into account)
      }
      # --wrap-width=110
      # --selector-width=40
      # --no-selector-column
      # --open-brace-whitespace="|s"
      # --document-comment-whitespace="n|n"
      # --semicolon-whitespace="|s"
    end
  end
end
