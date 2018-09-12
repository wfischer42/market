class Vendor
  attr_reader :name,
              :inventory
  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(type)
    @inventory[type.downcase]
  end

  def stock(type, count)
    @inventory[type.downcase] += count
  end

  def sell(type, count)
    type = type.downcase
    difference = @inventory[type] - count
    @inventory[type] = [difference, 0].max
    return [0, difference].min * -1
  end
end
