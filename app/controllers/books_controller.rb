class BooksController < ApplicationController
    def index
		@books = Book.all
		@book = Book.new
	end

    def create
    	@books = Book.all
		@book = Book.new(book_params)
		if @book.save
		flash[:notice] = "Book was successfully created"
		redirect_to book_path(@book.id) #投稿詳細画面(show)
	    else
	    render :index #投稿画面のままerrorを表示させたい(index)
	    end
	end

	def show
	    @book = Book.find(params[:id])

	end

	def edit
		@book = Book.find(params[:id])

	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		flash[:notice] = "Book was successfully updated"#
		redirect_to book_path(@book.id)#show画面へ
		else
	    render :edit #編集画面のままerrorを表示させたい(edit)
	    end
	end

	def destroy
		book = Book.find(params[:id])
		if book.destroy
		flash[:notice] = "Book was successfully destroyed"
		redirect_to books_path
		end
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
