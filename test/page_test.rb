require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_page
    VCR.use_cassette("test_page") do
      res = BokChoy.page(6589171)
      assert_match(/^\d{4}$/, res['reference']['yearAggr'].to_s)
    end
  end

  def test_page_title
    VCR.use_cassette("test_page") do
      res = BokChoy.page(6589171)
      assert_equal('Proceedings of the Linnean Society of New South Wales', res['reference']['titleName'])
    end
  end

  def test_page_id
    VCR.use_cassette("test_page") do
      res = BokChoy.page(6589171)
      assert_equal(6589171, res['reference']['pageId'])
    end
  end

  def test_page_url
    VCR.use_cassette("test_page") do
      res = BokChoy.page(6589171)
      assert_equal('https://www.biodiversitylibrary.org/page/6589171', res['reference']['url'])
    end
  end

end