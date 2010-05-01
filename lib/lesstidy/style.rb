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

    def defaults
      { :wrap_width      => 110,    # nil for no wrap
        :selector_width  => 40,     # nil for no columning
        :open_brace      => "{ ",
        :close_brace     => "}\n",
        :semicolon       => "; ",   # Add NLs after if needed
        :property_width  => nil,
        :colon           => ": ",   # Add spaces if needed
        :comma           => ", ",   # Spaces if needed
        :subrule_indent  => 2,
        :subrule_before  => "\n",
        :property_indent => 42,
      }
    end
  end
end
