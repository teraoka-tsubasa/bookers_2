class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show ,:edit ,:index]
	before_action :correct_user, only: [:edit ,:update]

	def new
		@user = User.new
	end


	def show
		@book = Book.new
		@user = User.find(params[:id])
		@books = @user.books

	end

	def edit
		@user = current_user
	end

	def index
		@book = Book.new
		@users = User.all
		@user = current_user
	end

	def update
		@user = current_user
	    if @user.update(user_params)
			flash[:notice] = "You have creatad book successfully."
		    redirect_to user_path(@user.id)
	    else
	    	render :edit
	    end
	end

	def destory
		super
        session[:keep_signed_out] = true
        redirect_to op_path
	end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
    end

     def correct_user
    	@user = User.find(params[:id])
    	if @user.id != current_user.id

			redirect_to user_path(current_user.id)
		end
    end

end
