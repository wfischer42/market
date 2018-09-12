require_relative './test_helper'
require_relative '../lib/market'
require_relative '../lib/vendor'

class MarketVendorIntegrationTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor1.stock("Peaches", 35)
    @vendor1.stock("Tomatoes", 7)
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor2.stock("Banana Nice Cream", 50)
    @vendor2.stock("Peach-Raspberry Nice Cream", 25)
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @vendor3.stock("Peaches", 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
  end

  def test_it_cant_sell_items_with_insufficient_stock
    refute @market.sell("Peaches", 200)
  end

  def test_it_sells_items_from_first_vendor_first
    @market.sell("Peaches", 1)
    assert_equal 34, @vendor1.check_stock("Peaches")
  end

  def test_it_sells_from_subsequent_vendors_after_previous_runs_out
    @market.sell("Peaches", 90)
    assert_equal 0, @vendor1.check_stock("Peaches")
    assert_equal 10, @vendor3.check_stock("Peaches")
  end
end
