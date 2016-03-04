class Cart < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :items
	has_many :positions
	has_many :items, through: :positions

	def add_item(i)
		if items.include?(i)
			positions.where(item_id: i.id).first.increment!(:quantity)
		else
			positions.create(item: i, quantity: 1)
		end
	end

	def remove_position(position_to_remove_id)
		positions.where(item_id: position_to_remove_id).first.try(:destroy)
	end

	# def remove_item(i)
	# 	if items.include?(i) && positions.where(item_id: i.id).first.quantity >= 0
			
	# 	else
	# 		positions.create(item: i, quantity: 1)
	# 	end
	# end	


	# cart.positions.where(item_id: 99).first.try(:destroy)
end
