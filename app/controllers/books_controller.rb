class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_book, only: [:edit]

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice] = "You have creatad book successfully."
		redirect_to book_path(@book)
	else
		@books = Book.all
		@user = current_user
		render :index
	end
	end


	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end


	def show
		@book_new = Book.new
		@book = Book.find(params[:id])
		@user = current_user
	end


	def edit
		@book = Book.find(params[:id])

	end


	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "Book was successfully update"
		redirect_to book_path(@book.id)
	else
		render :edit
	end
	end


	def destroy
		book = Book.find(params[:id])
		book.destroy
		flash[:notice] = "Book was successfully deleted"
        redirect_to books_path
	end


	private

	def book_params
        params.require(:book).permit(:title, :body, :image)
    end
    def correct_book
    	@book = Book.find(params[:id])
    	if @book.user_id != current_user.id

			redirect_to books_path
		end

    end

end
