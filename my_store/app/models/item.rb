class Item < ActiveRecord::Base
	validates :price, { numericality: {greater_than: 0}}
end
