module ItemsHelper
	def can_edit_item?(item)
		current_user (current_user.admin ||	item.category.administrator == current_user)
	end
end
