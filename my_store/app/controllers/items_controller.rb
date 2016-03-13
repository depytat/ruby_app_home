class ItemsController < ApplicationController

	# before_filter :has_admin_privileges?, only: [:new, :create, :edit, :update, :destroy]
	before_filter :has_admin_privileges?, except: [:index, :show]

	before_filter :find_item, only: [:show, :edit, :update, :destroy]




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
		# @category = Category.find(params[:category_id])
		render_404 and return unless @item.category_id == params[:category_id]
	end

	def new
		@item = Item.new
	end

	# def create
	# 	# @item = Item.create(params[:item])
	# 	item_params = params.require(:item).permit(:name, :description, :price, :weight)
	# 	@item = Item.create(item_params)
	# 	if @item.errors.empty?
	# 		redirect_to @item
	# 	else
	# 		render "new"
	# 	end
	# end

	def create
		item_params = params.require(:item).permit(:name, :description, :price, :weight)
		@item = Item.create(item_params)
		if @item.errors.empty?
			redirect_to @item
		else
			render "new"
		end
	end

	def edit
	end

	def update
		item_params = params.require(:item).permit(:name, :description, :price, :weight)
		@item.update_attributes(item_params)
		if @item.errors.empty?
			redirect_to @item
		else
			render "edit"
		end
	end

	def destroy
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

	private

		def has_admin_privileges?
			# unless current_user
			# 	redirect_to "/users/sign_in" and return
			# end

			# unless current_user.admin
			# 	render(file: "public/403.html", status: "403.html") and return
			# end
			# true

			redirect_to "/users/sign_in" unless current_user
			render(file: "public/403.html",
			status: "403.html") unless current_user.admin
		end

		def find_item
			@item = Item.find(params[:id])
		end
end
