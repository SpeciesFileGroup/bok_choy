require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_taxon_items_kingdom
    VCR.use_cassette("test_taxon_refs") do
      res = BokChoy.taxon_items(taxon_name: 'Lepidoptera')
      assert_equal('Animalia', res[0]['mainKingdom'])
    end
  end

  def test_taxon_items_order
    VCR.use_cassette("test_taxon_refs") do
      res = BokChoy.taxon_items(taxon_name: 'Lepidoptera')
      assert_equal('Lepidoptera', res[0]['mainOrder'])
    end
  end

  def test_taxon_items_year
    VCR.use_cassette("test_taxon_refs") do
      res = BokChoy.taxon_items(taxon_name: 'Lepidoptera')
      assert_match(/^\d{4}$/, res[0]['titleYearStart'].to_s)
    end
  end

end