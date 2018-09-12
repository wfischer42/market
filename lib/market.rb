require_relative './vendor'

class Market
  attr_reader :name,
              :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def sorted_item_list
    list = @vendors.flat_map do |vendor|
      vendor.inventory.keys
    end.uniq
    list.sort
  end

  def total_inventory
    @vendors.inject(Hash.new(0)) do |inventory, vendor|
      merge_vendor_inventory(inventory, vendor)
    end
  end

  def merge_vendor_inventory(inventory, vendor)
    inventory.merge(vendor.inventory) do |key, total, added|
      total + added
    end
  end
end
