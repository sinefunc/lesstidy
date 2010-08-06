require 'helper'

class TestLesstidy < Test::Unit::TestCase
  should "Satisfy some simple tests" do
    t("div { color: red; }")
    t("div + div { color: red; }")
  end

private
  def t(css)
    Lesstidy::Document.new css
  end
end
