require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_references_year
    VCR.use_cassette("test_references_year") do
      res = BokChoy.references(6589171)
      assert_match(/^\d{4}$/, res['titleYearStart'].to_s)
    end
  end

  def test_references_kingdom
    VCR.use_cassette("test_references_kingdom") do
      res = BokChoy.references(6589171)
      assert_equal('Animalia', res['itemStats']['mainKingdom'].to_s)
    end
  end

end