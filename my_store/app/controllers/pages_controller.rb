class PagesController < ApplicationController
	def frontpage
		@latest_items = Item.order('created_at DECS').limit(3)
		# flash[:success] # => "Welcome dear user!"
	end
end
