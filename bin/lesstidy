#!/usr/bin/env ruby

require "optparse"

options = {}
opts = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($PROGRAM_NAME)}"

  opts.on( "-q", "--quaffle", String, "Something") do |opt|
    options[:quaffle] = opt
  end

  opts.separator ""
  opts.on_tail( "-h", "--help", "Shows this message" ) do
    puts opts
  end
end
opts.parse!
options[:input] = ARGV[0] if ARGV.size > 0
options[:output] = ARGV[1] if ARGV.size > 1

#LessTidy::Engine.new( options ).run
