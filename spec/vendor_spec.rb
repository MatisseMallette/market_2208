require 'rspec'
require './lib/vendor'
require './lib/item'


RSpec.describe Vendor do 
  before(:each) do 
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
  end

  it 'exists' do 
    expect(@vendor).to be_an_instance_of(Vendor)
  end

  it 'has readable attributes' do 
    expect(@vendor.name).to eq("Rocky Mountain Fresh")
    expect(@vendor.inventory).to eq({})
  end

  it 'can check stock' do 
    expect(@vendor.check_stock(@item1)).to eq(0)
  end

  it 'can stock item' do 
    @vendor.stock(@item1, 30)
    expect(@vendor.check_stock(@item1)).to eq(30)
    @vendor.stock(@item1, 30)
    expect(@vendor.check_stock(@item1)).to eq(60)
  end

  it 'can give potential revenue' do 
    @vendor.stock(@item1, 65)
    r = 0.75 * 65.0
    expect(@vendor.potential_revenue).to eq(r)
  end
end