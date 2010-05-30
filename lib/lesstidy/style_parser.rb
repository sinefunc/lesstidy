module Lesstidy
  class StyleParser
    class << self
      def preset_path(*args)
        @preset_path ||= File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. data presets]))
        File.join(@preset_path, *args)
      end

      def load_preset(preset_name = '')
        return {}  if preset_name == 'default'

        preset_file = File.join(preset_path, preset_name)

        raise PresetNotFoundError, preset_file unless File.exists?(preset_file)
        preset_data = File.open(preset_file) { |f| f.read.split("\n") }

        load_options preset_data
      end

      def presets
        ['default'] + Dir[preset_path '**'].map { |file| File.basename(file) }
      end

      # Returns the defaults
      def defaults
        dir = Dir.pwd
        while true do
          fname = File.join(dir, '.lesstidyopts')

          return File.open(fname) { |f| f.read.split("\n").reject(&:empty?) } \
             if File.exists?(fname)

          _dir = File.expand_path(File.join(dir, '..'))
          return []  if dir == _dir
          dir = _dir
        end
      end

      # Input: array of options, or hash, or string?
      # Output: hash to be fed into Style.new
      def load_options(args)
        opts = {}

        if args.is_a? Array
          parser = OptionParser.new { |o| parse(o, opts) }
          parser.parse args
        end

        opts = opts.merge args  if args.is_a? Hash
        opts = load_preset(args)  if args.is_a? String
        opts = load_preset(opts[:preset]).merge(opts)  unless opts[:preset].nil?
        opts
      end

      def parse(o, opt)
        o.separator ""
        o.separator "Style options:"
        o.on('-p', '--preset', '=PRESET', "preset name to load") do |v|
          opt[:preset] = v
        end

        o.on('--no-wrap', "disables wrapping") do
          opt[:wrap_width] = nil
        end

        o.on('--wrap-width', '=N', "wrap width (overrides --no-wrap)") do |n|
          opt[:wrap_width] = n.to_i
        end

        o.on('--property-width', '=N', "width of properties (NOT implemented)") do |n|
          opt[:property_width] = n.to_i
        end

        o.on('--property-indent', '=N', "number of spaces to indent properties with") do |n|
          opt[:property_indent] = n.to_i
        end

        # Yeh, no-sel-wrap and sel-width are NOT mutex... ambiguous :|
        o.on('--no-selector-wrap', 'disables wrapping of long selectors (LessCSS compatibility)') do
          opt[:selector_wrap] = false
        end

        o.on('--selector-wrap', 'enables wrapping of long selectors') do
          opt[:selector_wrap] = true
        end

        o.on('--no-selector-column', 'disables selector column mode') do |n|
          opt[:selector_width] = nil
        end

        o.on('--selector-width', '=N', 'selector column mode; width of selectors before wrapping') do |n|
          opt[:selector_width] = n.to_i
        end

        o.on('--subrule-indent', '=N', 'number of spaces to indent a subrule with') do |n|
          opt[:subrule_indent] = n.to_i
        end

        o.on('--open-brace-spaces', '=FORMAT', '') do |fmt|
          opt[:open_brace] = fmt.tr('sn', " \n").gsub('|', '{')
        end

        o.on('--close-brace-spaces', '=FORMAT', '') do |fmt|
          opt[:close_brace] = fmt.tr('sn', " \n").gsub('|', '}')
        end

        o.on('--semicolon-spaces', '=FORMAT', '') do |fmt|
          opt[:semicolon] = fmt.tr('sn', " \n").gsub('|', ';')
        end

        o.on('--colon-spaces', '=FORMAT', '') do |fmt|
          opt[:colon] = fmt.tr('sn', " \n").gsub('|', ':')
        end
      end
    end
  end
end
