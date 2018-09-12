class Vendor
  attr_reader :name,
              :inventory
  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(type)
    @inventory[type.capitalize]
  end

  def stock(type, count)
    @inventory[type.capitalize] += count
  end
end
