class BooksController < ApplicationController

    def index
		@books = Book.all #他のユーザー（他id）の投稿も見れる
		@book = Book.new
		@user = current_user
	end

    def create
    	@user = current_user
    	@books = Book.all
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
		flash[:notice] = "Book was successfully created"
		redirect_to book_path(@book.id) #投稿詳細画面(show)
	    else
	    render :index #投稿画面のままerrorを表示させたい(index)
	    end
	end

	def show #復習する
	    @find_book = Book.find(params[:id])
		@book = Book.new
		@user = @find_book.user
	end

	def edit
		@book = Book.find(params[:id])
		@user = @book.user
		if @user == current_user
        else
        redirect_to books_path #bookindexへ
        end
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

	def user_params
        params.require(:user).permit(:name, :profile_image, :introduction)
    end

end
