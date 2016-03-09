class User < ActiveRecord::Base
	has_one 	:cart
	has_many  	:orders, dependent: :destroy
	has_many 	:images, as: :imageable
end
