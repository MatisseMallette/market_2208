require './lib/vendor'
require './lib/item'

class Market 
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    names = []
    @vendors.each {|vendor| names << vendor.name}
    return names
  end

  def vendors_that_sell(item)
    vendors_selling = @vendors.find_all {|vendor| vendor.inventory.include? item}
    return vendors_selling
  end

  def total_inventory 
    total = Hash.new {|k, v| k[v] = {:quantity=>0, :vendors=>[]}}
    @vendors.each do |vendor|
      vendor.inventory.each do |item| 
        total[item[0]][:quantity] += item[1]
        total[item[0]][:vendors] << vendor
      end
    end
    
    return total
  end

  def overstocked_items 
    overstocked = []
    self.total_inventory.each do |item, info| 
      if info[:quantity] > 30 
        overstocked << item 
      end
    end
    return overstocked
  end

  def sorted_item_list
    items = []
    self.total_inventory.each do |item, info|
      items << item.name
    end

    return items.sort { |a, b| a <=> b }
  end
end