require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_original_0
    VCR.use_cassette("test_ping") do
      res = BokChoy.ping
      assert_equal('pong', res)
    end
  end

end