class Treetop::Runtime::SyntaxNode
  def cascade(env)
    elements.each { |e| e.build env if e.respond_to? :build }  if elements.is_a? Array
    env
  end

  def build(env)
    cascade env
  end
end

