require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_items_year
    VCR.use_cassette("test_items_year") do
      res = BokChoy.items(73397)
      assert_match(/^\d{4}$/, res['titleYearStart'].to_s)
    end
  end

  def test_items_kingdom
    VCR.use_cassette("test_items_kingdom") do
      res = BokChoy.items(73397)
      assert_equal('Animalia', res['mainKingdom'].to_s)
    end
  end

end