require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_items_page_numbers
    VCR.use_cassette("test_items_page_numbers") do
      res = BokChoy.items_page_nums(item_id: 15402, page_num: 183)
      assert_equal 747864, res["pageId"]
    end
  end
end