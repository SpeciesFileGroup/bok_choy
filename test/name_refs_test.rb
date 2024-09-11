require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_namerefs_name_match_name
    VCR.use_cassette("test_name_refs") do
      res = BokChoy.name_refs(name: 'Cyphoderris strepitans', nomen_event: true)
      assert_equal('Cyphoderris strepitans', res['references'][0]['name']['matchName'])
    end
  end

  def test_namerefs_name_annotation
    VCR.use_cassette("test_name_refs") do
      res = BokChoy.name_refs(name: 'Cyphoderris strepitans', nomen_event: true)
      assert_match('NO_ANNOT', res['references'][0]['name']['annotNomen'])
    end
  end

  def test_namerefs_reference_year
    VCR.use_cassette("test_name_refs") do
      res = BokChoy.name_refs(name: 'Cyphoderris strepitans', nomen_event: true)
      assert_equal('1978', res['references'][0]['reference']['yearAggr'].to_s)
    end
  end

  def test_namerefs_reference_page
    VCR.use_cassette("test_name_refs") do
      res = BokChoy.name_refs(name: 'Cyphoderris strepitans', nomen_event: true)
      assert_equal(50929199, res['references'][0]['reference']['pageId'])
    end
  end

  def test_name_refs_json
    VCR.use_cassette("test_nomen_refs_json") do
      res = BokChoy.name_refs(json: {"name": {"nameString": "Pardosa moesta", "author": "Banks", "year": 1892}, "reference": {}, "params": {"nomenEvent": true}})
      assert_match(/^\d{4}$/, res['references'][0]['reference']['yearAggr'].to_s)
    end
  end

  def test_name_refs_nomen_event_true
    VCR.use_cassette("test_name_refs_nomen_event_true") do
      res = BokChoy.name_refs(name: 'Cyphoderris strepitans', nomen_event: true)
      assert_equal(true, res['meta']['input']['params']['nomenEvent'])
    end
  end

  def test_name_refs_json_reference_page
    VCR.use_cassette("test_nomen_refs_json") do
      res = BokChoy.name_refs(json: {"name": {"nameString": "Pardosa moesta", "author": "Banks", "year": 1892}, "reference": {}, "params": {"nomenEvent": true}})
      assert_equal(1656908, res['references'][0]['reference']['pageId'])
    end
  end
end