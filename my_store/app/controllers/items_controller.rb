class ItemsController < ApplicationController
	# def hello
	# 	# Следующая строка выведет в браузер приветствие
	# 	# (пока никакого html, просто текст)
	# 	render text: "This is ItemsController speaking, hello!"
	# end

	# def hello
	# 	render text: "This is ItemsController speaking, hello #{params[:first_name]} #{params[:family_name]}!"
	# end

	# def hello
	# 	render "hello"
	# end

	# def hello
	# # Сохраним в инстансной переменной количество товаров
	# 	@items_count = Item.count
	# 	@sign_in_time # => nil, т.е. переменная не установлена
	# 	render "greeting"
	# end


	# def goodbye
	# 	@logout_time = Time.now
	# end

	# def sign_in
	# 	if params[:login] == "admin" && params[:password] == "my_super_secure_password"
	# 		@sign_in_time = Time.now
	# 		redirect_to action: "hello"
	# 	else
	# 		render text: "Access denied", status: 403
	# 	end
	# end

	def index
		# @items = Item.all
		# @items = Item.paginate(per_page: 10, page: params[:page])

		@items = Item
		# Выводим только активные товары
		@items = @items.where(active: true)
		# Устанавливаем сортировку
		order = params[:order] == "asc" ? "asc" : "desc"
		@items = @items.order("created_at #{order}")
		@items = @items.paginate(per_page: 10, page: params[:page])
	end

	def show
		@item = Item.find(params[:id])
	end

	def new
		@item = Item.new
	end

	def create
		# @item = Item.create(params[:item])
		item_params = params.require(:item).permit(:name, :description, :price, :weight)
		@item = Item.create(item_params)
		if @item.errors.empty?
			redirect_to @item
		else
			render "new"
		end
	end

	def edit
		@item = Item.find(params[:id])
	end

	def update
		item_params = params.require(:item).permit(:name, :description, :price, :weight)
		@item = Item.find(params[:id])
		@item.update_attributes(item_params)
		if @item.errors.empty?
			redirect_to @item
		else
			render "edit"
		end
	end

	def destroy
		@item = Item.find(params[:id])
		@item.destroy
		redirect_to items_path
	end

	def activate
		@item = Item.find(params[:id])
		@item.active = true
		@item.save
	end

	def top
		@items = Item.where(active: true).order('rating DESC').limit(10)
	end
end
