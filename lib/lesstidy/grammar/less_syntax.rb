class Treetop::Runtime::SyntaxNode
  def cascade(env)
    elements.each { |e| e.build env if e.respond_to? :build }  if elements.is_a? Array
    env
  end

  def build(env)
    cascade env
  end
end

class Treetop::Runtime::CompiledParser
  def failure_message
    o = lambda {|i, *args| i }
    return nil unless (tf = terminal_failures) && tf.size > 0
    msg = "on line #{failure_line}: expected " + (
      tf.size == 1 ?
        o[tf[0].expected_string, :yellow] :
        "one of #{o[tf.map {|f| f.expected_string }.uniq * ' ', :yellow]}"
    )
    f = input[failure_index]
    got = case f
      when "\n" then o['\n',  :cyan]
      when nil  then o["EOF", :cyan]
      when ' '  then o["white-space", :cyan]
      else           o[f.chr, :yellow]
    end
    msg += " got #{got}" # after:\n\n#{input[index...failure_index]}\n"
  end
end
