require 'helper'

class TestBlackbox < Test::Unit::TestCase
  Dir[File.join(File.dirname(__FILE__), 'fixtures', '*.control.css')].each do |file|
    name = /^(.*)\.control\.css$/.match(File.basename(file))[1]
    path = File.dirname(file)
    inspect = File.join(path, "#{name}.inspect.txt")
    
    should "Work for #{name}" do
      @input = Lesstidy::Document.load file
      control = File.open(inspect) { |f| f.read }
      assert_equal control.strip, @input.inspect.strip

      # Test default
      output = File.open(File.join(path, "#{name}.default.css")) { |f| f.read }
      assert_equal @input.to_css.strip, output.strip

      # Test terse
      style = Lesstidy::Style.new "terse"
      control = File.open(File.join(path, "#{name}.terse.css")) { |f| f.read }
      unknown = @input.to_css(style).strip
      assert_equal unknown, control.strip

      @input2 = Lesstidy::Document.load File.join(path, "#{name}.terse.css")
      assert_equal @input.to_css(style).strip, @input2.to_css(style).strip
    end
  end
end

