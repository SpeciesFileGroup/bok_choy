require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_name_refs
    VCR.use_cassette("test_name_refs") do
      res = BokChoy.name_refs(scientific_name: 'Achenium lusitanicum', authors: 'Skalitzky', year: 1884)
      assert_match(/^\d{4}$/, res['references'][0]['reference']['yearAggr'].to_s)
    end
  end

  def test_name_refs_json
    VCR.use_cassette("test_name_refs_json") do
      res = BokChoy.name_refs(json: {"id": "11111", "name": {"authors": "Skalitzky", "nameString": "Achenium lusitanicum", "year": 1884}})
      assert_match(/^\d{4}$/, res['references'][0]['reference']['yearAggr'].to_s)
    end
  end

end