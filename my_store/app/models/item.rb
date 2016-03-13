class Item < ActiveRecord::Base

	# attr_accessible :name, :description, :price, :weight 

	# attr_accessor :made_in # обратите внимание,  это не метод attr_accessible!

	# after_initialize do
	# 	@made_in = "China"
	# end

	# validates :price, :weight, { numericality: {greater_than: 0}, presence: true }
	validates :price,  numericality: { greater_than: 0 }
	validates :weight, numericality: { greater_than: 0 }, on: :create
	validates :name,   presence: true

	has_and_belongs_to_many :carts
	has_many :positions
	has_many :carts, through: :positions
	has_many :images, as: :imageable

	# after_create :increment_category_counter
	# after_destroy :decrement_category_counter

	# private
	# 	def increment_category_counter
	# 		category.inc!(:items_count)
	# 	end

	# 	def decrement_category_counter
	# 		category.inc!(:items_count, -1)
	# 	end

		#можно было и так записать
		# after_create do
		# 	category.inc!(:items_count)
		# end
		# after_destroy do
		# 	category.inc!(:items_count, -1)
		# end

	def homepage=(url)
		write_attribute :homepage, url.sub('http://', '')
	end	
end
