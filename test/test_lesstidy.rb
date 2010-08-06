require 'helper'

class TestLesstidy < Test::Unit::TestCase
  pass_tests = {
    pass1: "div { color: red; }",
    pass2: "div + div { color: red; }",
    pass3: "div[name=foo] { color: red; }",
    pass4: "div[name='foo'] { color: red; }",
    pass5: "div[name='foo'] { .gradient('$*&!*@#()&!#'); }"
  }

  fail_tests = {
    fail1: "div[name='foo'] { .gradient($*&!(*@#&!#); }"
  }

  pass_tests.each do |key, test|
    should("Satisfy test #{key}") { t test }
  end

  fail_tests.each do |key, test|
    should "Fail test #{key}" do
      assert_raises(::Lesstidy::ParseError) { Lesstidy::Document.new(test) }
    end
  end

private
  def t(css)
    Lesstidy::Document.new css
  end
end
