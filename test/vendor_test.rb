require_relative './test_helper'
require_relative '../lib/vendor'

class VendorTest < Minitest::Test
  def setup
    @vendor = Vendor.new('Rocky Mountain Fresh')
  end

  def test_it_exists_with_name
    assert_instance_of Vendor, @vendor
    assert_equal 'Rocky Mountain Fresh', @vendor.name
  end

  def test_it_has_empty_inventory_by_default
    empty = {}
    assert_equal empty, @vendor.inventory
    assert_equal 0, @vendor.check_stock('peaches')
  end

  def test_it_can_stock_items
    @vendor.stock('peaches', 30)
    @vendor.stock('peaches', 20)
    @vendor.stock('rocket fuel', 1000)

    assert_equal 50, @vendor.check_stock('peaches')
    assert_equal 1000, @vendor.check_stock('rocket fuel')
  end

  def test_it_can_sell_some_items_and_return_no_shortage
    @vendor.stock('peaches', 30)
    shortage = @vendor.sell('peaches', 20)

    assert_equal 0, shortage
    assert_equal 10, @vendor.check_stock('peaches')
  end

  def test_it_can_sell_all_items_and_return_shortage
    @vendor.stock('peaches', 30)
    shortage = @vendor.sell('peaches', 40)

    assert_equal 10, shortage
    assert_equal 0, @vendor.check_stock('peaches')
  end
end
