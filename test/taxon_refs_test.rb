require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_taxon_refs
    VCR.use_cassette("test_taxon_refs") do
      res = BokChoy.taxon_refs(scientific_name: 'Achenium lusitanicum', authors: 'Skalitzky', year: 1884)
      assert_match(/^\d{4}$/, res['references'][0]['reference']['yearAggr'].to_s)
    end
  end

  def test_taxon_refs_json
    VCR.use_cassette("test_taxon_refs_json") do
      res = BokChoy.taxon_refs(json: {"id": "11111", "name": {"authors": "Skalitzky", "nameString": "Achenium lusitanicum", "year": 1884}})
      assert_match(/^\d{4}$/, res['references'][0]['reference']['yearAggr'].to_s)
    end
  end

end