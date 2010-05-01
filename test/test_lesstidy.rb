require 'helper'

class TestLesstidy < Test::Unit::TestCase
  def t( a )
    CSSParser.new.parse a
  end

  def try( a )
    p = CSSParser.new.parse a
    assert !p.nil?
    puts p.lol if p.respond_to? :lol
    puts ""
  end

  should "probably rename this file and start testing for real" do
    try ""
    try "div { color: red; }"
    try "div{color:red;}"
    try "div,div { color: red; }"
    try "div,div { .lol(); color: red; }"
    try "div,div { color: red; font-weight: bold; }"
    try "div,div { color: red; font-weight: bold; /* wtf */ }"
  end
end
