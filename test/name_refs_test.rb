require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_namerefs_name_match_name
    VCR.use_cassette("test_name_refs") do
      res = BokChoy.name_refs(name: 'Pardosa moesta', reference: 'Docums Mycol. 34(nos 135-136)', nomen_event: true)
      assert_equal('Pardosa moesta', res['references'][0]['name']['matchName'])
    end
  end

  def test_namerefs_name_annotation
    VCR.use_cassette("test_name_refs") do
      res = BokChoy.name_refs(name: 'Pardosa moesta', reference: 'Docums Mycol. 34(nos 135-136)', nomen_event: true)
      assert_match('SP_NOV', res['references'][0]['name']['annotNomen'])
    end
  end

  def test_namerefs_reference_year
    VCR.use_cassette("test_name_refs") do
      res = BokChoy.name_refs(name: 'Pardosa moesta', reference: 'Docums Mycol. 34(nos 135-136)', nomen_event: true)
      assert_match(/^\d{4}$/, res['references'][0]['reference']['yearAggr'].to_s)
    end
  end

end