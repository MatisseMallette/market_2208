class Vendor 
  attr_reader :name, :inventory
  def initialize(name)
    @name = name 
    @inventory = Hash.new {|k, v| k[v] = 0}
  end

  def check_stock(item) 
    return @inventory[item]
  end

  def stock(item, amount)
    @inventory[item] += amount 
  end

  def potential_revenue
    potential = 0.0
    @inventory.each do |item| 
      for i in 1..item[1] do 
        potential += item[0].price[1..-1].to_f
      end
    end
    return potential
  end
end