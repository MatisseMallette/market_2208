require 'rspec'
require './lib/market'
require './lib/vendor'
require './lib/item'

RSpec.describe Market do 
  before(:each) do 
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
  end

  it 'exists' do 
    expect(@market).to be_an_instance_of(Market)
  end

  it 'has readable attributes' do 
    expect(@market.name).to eq("South Pearl Street Farmers Market")
    expect(@market.vendors).to eq([])
  end

  it 'can add vendors' do 
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
  end

  it 'can list vendor names' do 
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendor_names).to eq(['Rocky Mountain Fresh', 'Ba-Nom-a-Nom', 'Palisade Peach Shack'])
  end

  it 'can list vendors who sell a specific item' do 
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
  end

  it 'can list total inventory' do 
    @market.add_vendor(@vendor1) 
    expect(@market.total_inventory).to eq(
      {
        @item1 => {:quantity=>35, :vendors=>[@vendor1]}, 
        @item2 => {:quantity=>7, :vendors=>[@vendor1]}
      }
    )
  end

  it 'can list overstocked items' do 
    @market.add_vendor(@vendor1) 
    expect(@market.overstocked_items).to eq([@item1])
  end

  it 'can list items alphabetically' do 
    @market.add_vendor(@vendor1)
    expect(@market.sorted_item_list).to eq(['Peach', 'Tomato'])
  end
end