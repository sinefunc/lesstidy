module Lesstidy
  class Preset
    def options_parse(o)
      o.on('-w', '--wrap', "Wrap") do
        # ...
      end
    end

    def self.[](name)
    end
  end
end
