class Item < ActiveRecord::Base

	attr_accessible :name, :description, :price, :weight 

	attr_accessor :made_in # обратите внимание,  это не метод attr_accessible!

	after_initialize do
		@made_in = "China"
	end

	# validates :price, :weight, { numericality: {greater_than: 0}, presence: true }
	validates :price,  numericality: { greater_than: 0 }
	validates :weight, numericality: { greater_than: 0 }, on: :create
end
