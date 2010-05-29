module CUtil
  class String < ::String
    def prepend!(str)
      self.replace(str + self)
    end

    def append!(str)
      self << str
    end

    def wrap!(args = {})
      temp = self.wrap(args)
      self.replace(temp)
      #self.replace(self.wrap(*args))
    end

    def lasplit(regex)
      a = []
      split(regex).each_slice(2) { |i| a << i.join('') }
      a
    end

    def wrap(args = {})
      # Inherit the given hashes
      options = args
      options[:regexp] ||= /([;,])/
      options[:indent] ||= 0
      options[:first_indent] ||= options[:indent]
      options[:wrap_spaces] = true  if options[:wrap_spaces].nil?

      width = options[:width]

      first_indent = options[:first_indent]
      indent = ''
      indent = ' ' * options[:indent]  if options[:indent]

      ret = self.lasplit(options[:regexp]).inject(['']) do |a, chunk|
        nl = a[-1] + chunk

        line_width = first_indent ? (width - first_indent) : width
        if nl.rstrip.size > line_width
          # To wrap...
          a << (indent + chunk.lstrip)
          first_indent = false

          # If the new line exceeds the line width, rewrap!
          if a[-1].size > width and not options[:no_rewrap]
            a[-1] = String.new(a[-1])  unless a[-1].is_a? String
            wrapped = [a[-1]]
            wrapped = a[-1].wrap(args.merge({ :regexp => /( +)/, :no_rewrap => true, :array => true, :pad => false }))  if options[:wrap_spaces]
            a = a[0..-2] + wrapped
          end
        else
          # Or not to wrap
          a[-1] = nl
        end
        a
      end

      # Pad the last line with spaces
      ret[-1] = ret[-1] + (" " * [width - ret[-1].size, 0].max)  if options[:pad]

      # Stringify if needed
      options[:array] ? ret : ret.join("\n")
    end
  end
end

