require 'helper'

class TestBlackbox < Test::Unit::TestCase
  Dir[File.join(File.dirname(__FILE__), 'fixtures', '*.control.css')].each do |file|
    name = /^(.*)\.control\.css$/.match(File.basename(file))[1]
    path = File.dirname(file)
    inspect = File.join(path, "#{name}.inspect.txt")
    
    should "Work for #{name}" do
      @input = CSS::Document.load file
      control = File.open(inspect) { |f| f.read }
      assert_equal control.strip, @input.inspect.strip
    end
  end
end

