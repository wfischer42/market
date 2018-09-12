class Vendor
  attr_reader :name,
              :inventory
  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(type)
    @inventory[type]
  end

  def stock(type, count)
    @inventory[type] += count
  end
end
