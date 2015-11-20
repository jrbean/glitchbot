require "test_helper"

class RulesTest < ActiveSupport::TestCase
  setup do
    @p = Plugins::Rules.new
  end

  test "it matches appropriately" do
    assert @p.matches? "text" => "marvin, what are the rules?"
    assert @p.matches? "text" => "marvin remember the rules!"
    refute @p.matches? "text" => "marvin echo something"
  end

  test "it knows the rules" do
    resp = @p.handle "text" => "marvin the rules"
    assert 3, resp.lines.count
    assert_includes resp.downcase, "a robot may not injure a human being"
  end
end
