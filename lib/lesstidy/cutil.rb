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

    # Options:
    #   width:        (Integer) The text width
    #
    # Optional options:
    #   first_indent: (Integer) how much the first line will be padded with. No
    #                 actual padding will be added, but it'll be factored
    #                 into wrapping.
    #   pad:          (Boolean) Pad the last line with spaces to make the width
    #   array:        (Boolean) return an array if true, else a string
    #
    def wrap(options)
      regexp  = options[:regexp] || /([;,]\s*)/
      width   = options[:width]

      ret = array_wrap(self.split(regexp), options)

      # Pad the last line with spaces
      ret[-1] = ret[-1] + (" " * [width - ret[-1].size, 0].max)  if options[:pad]

      # Return as array or string
      options[:array] ? ret : ret.join("\n")
    end

  private
    def array_wrap(split_arr, o)
      findent = o[:first_indent] || o[:indent] || 0
      indent  = ' ' * (o[:indent] || 0)

      ret = Array.new

      split_arr.each_slice(2) do |(chunk, chunk_ws)|
        line = ret[-1] || ''
        if (findent + line.size + chunk.size) > o[:width] # New line
          ret << [(indent unless ret.empty?), chunk, chunk_ws].join
          findent = 0
        else
          (ret[-1] or ret[0]='') << [chunk, chunk_ws].join
        end
      end

      ret
    end
  end
end

