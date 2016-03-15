
require 'spec_helper'

describe Item

	it "calculates the correct price for the item that includes a tax" do
	item = Item.new(price: 10)
	item.price_with_tax.should == 13
	end
