require "test_helper"

class PugsTest < ActiveSupport::TestCase
  def setup
    @p = Plugins::Pugs.new
  end

  test "it complains about unreasonable requests" do
    resp = @p.handle "text" => "marvin pug bomb 1000"
    assert_equal "That's too many pugs", resp
  end

  test "it can serve up a pug" do
    resp = @p.handle "text" => "marvin pug me"
    assert_includes resp, "media.tumblr.com"
  end
end
