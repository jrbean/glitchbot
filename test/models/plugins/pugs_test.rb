require "test_helper"

class PugsTest < ActiveSupport::TestCase
  def setup
    @p = Plugins::Pugs.new
  end

  test "it complains about unreasonable requests" do
    resp = @p.handle "text" => "glitch pug bomb 1000"
    assert_equal "too many pugs, dude", resp
  end

  test "it can serve up a pug" do
    VCR.use_cassette "1 pug", re_record_interval: 1.week do
      resp = @p.handle "text" => "glitch pug me"
      assert_includes resp, "media.tumblr.com"
    end
  end

  test "it can serve up multiple pugs" do
    VCR.use_cassette "4 pugs", re_record_interval: 1.week do
      resp = @p.handle "text" => "glitch pug bomb 4"
      assert 4, resp.count
      resp.each do |url|
        assert_includes url, "media.tumblr.com"
      end
    end
  end
end
