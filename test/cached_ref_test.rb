require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_cached_refs_year
    VCR.use_cassette("test_cached_refs_year") do
      res = BokChoy.cached_refs('6C8Q2')
      assert_equal(1978, res['references'][0]['reference']['yearAggr'])
    end
  end

  def test_cached_refs_kingdom
    VCR.use_cassette("test_cached_refs_kingdom") do
      res = BokChoy.cached_refs('6C8Q2')
      assert_equal('Animalia', res['references'][0]['reference']['itemStats']['mainKingdom'])
    end
  end

end