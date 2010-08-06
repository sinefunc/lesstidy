require 'helper'

class TestLesstidy < Test::Unit::TestCase
  pass_tests = {
    pass1: "div { color: red; }",
    pass2: "div + div { color: red; }",
    pass3: "div[name=foo] { color: red; }",
    pass4: "div[name='foo'] { color: red; }",
    pass5: "div[name='foo'] { .gradient('$*&!*@#()&!#'); }",
    pass6: "tt { a: b; }",
    pass7: "#menu a,div { color: red; font-weight: bold; } #menu ul li > div, td, tr, #menu a:hover div #lol yes yes .something span.clear-fix, table { text-align: center; .black; font-weight: bold; border: solid 2px #882828; cursor: default; background-repeat: no-repeat; } a:hover { .corner(5px); background: url(foo.png); span { font-weight: bold; } span, a:hover, a:active, a:hover span, a:active span { text-decoration: underline; strong em { color: blue; } } }",
  }

  fail_tests = {
    fail1: "div[name='foo'] { .gradient($*&!(*@#&!#); }",
    fail2: "tt { a: b }",
    fail3: "tt { a }",
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
