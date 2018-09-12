require_relative './test_helper'
require_relative '../lib/market'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new('South Pearl Street Farmers Market')

    #Stubs
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

    expected1 = [@vendor_stubs[1], @vendor_stubs[4]]
    assert_equal expected1, @market.vendors_that_sell('peaches')
  end

  def test_it_can_sort_items_sold_by_all_vendors
    inventories = [{"Peaches" => 100, "Apricots" => 80, "Mangos" => 30},
                   {"Apricots" => 100, "Bananas" => 80, "Pears" => 30},
                   {"Mangos" => 100, "Pears" => 80, "Peaches" => 30},
                   {"Apricots" => 100, "Zucchinis" => 80, "Bananas" => 30},
                   {"Cucumbers" => 100, "Apricots" => 80, "Bananas" => 30}]
    @vendor_stubs.each_with_index do |vendor, i|
      vendor.expects(:inventory).returns(inventories[i])
      @market.add_vendor(vendor)
    end

    expected = ["Apricots", "Bananas", "Cucumbers",
                "Mangos", "Peaches", "Pears", "Zucchinis"]

    assert_equal expected, @market.sorted_item_list
  end

  def test_it_can_list_total_inventory_for_all_vendors
    inventories = [{"Peaches" => 100, "Apricots" => 80},
                   {"Apricots" => 10, "Bananas" => 30},
                   {"Mangos" => 80, "Pears" => 80},
                   {"Apricots" => 20, "Zucchinis" => 80},
                   {"Cucumbers" => 40, "Apricots" => 20}]
    @vendor_stubs.each_with_index do |vendor, i|
      vendor.expects(:inventory).returns(inventories[i])
      @market.add_vendor(vendor)
    end

    expected = {"Apricots" => 130, "Bananas" => 30, "Cucumbers" => 40,
                "Mangos" => 80, "Peaches" => 100, "Pears" => 80,
                "Zucchinis" => 80}

    assert_equal expected, @market.total_inventory
  end
end
