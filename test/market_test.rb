require_relative './test_helper'
require_relative '../lib/market'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new('South Pearl Street Farmers Market')

    names = ["Vendor 1", "Vendor 2", "Vendor 3", "Vendor 4", "Vendor 5"]
    @vendor_stubs = names.map do |name|
      stub("Vendor", name: name)
    end
  end

  def test_it_exists_with_name
    assert_instance_of Market, @market
    assert_equal 'South Pearl Street Farmers Market', @market.name
  end

  def test_it_has_no_vendors_by_default
    assert_equal [], @market.vendors
  end

  def test_it_can_add_vendors
    @vendor_stubs.each do |vendor|
      @market.add_vendor(vendor)
    end

    assert_equal @vendor_stubs, @market.vendors
  end

  def test_it_can_display_vendor_names
    @vendor_stubs.each do |vendor|
      @market.add_vendor(vendor)
    end

    expected = ['Vendor 1', 'Vendor 2', 'Vendor 3', 'Vendor 4', 'Vendor 5']
    assert_equal expected, @market.vendor_names
  end

  def test_it_can_find_all_venders_that_sell_a_given_item
    peaches = [0, 100, 0, 0, 5]
    @vendor_stubs.each_with_index do |vendor, i|
      vendor.expects(:check_stock).with('peaches').returns(peaches[i])
      @market.add_vendor(vendor)
    end

    expected = [@vendor_stubs[1], @vendor_stubs[4]]
    assert_equal expected, @market.vendors_that_sell('peaches')
  end

  def test_case_name

  end
end
