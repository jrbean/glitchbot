require "test_helper"

class RulesTest < ActiveSupport::TestCase
  test "it matches appropriately" do
    p = Plugins::Rules.new

    assert p.matches? "text" => "marvin, what are the rules?"
    assert p.matches? "text" => "marvin remember the rules!"
    refute p.matches? "text" => "marvin echo something"
  end

  test "it knows the rules" do
    p = Plugins::Rules.new

    resp = p.handle "text" => "marvin the rules"
    assert 3, resp.lines.count
    assert_includes resp.downcase, "a robot may not injure a human being"
  end
end
