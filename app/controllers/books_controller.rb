class BooksController < ApplicationController

  def index
    @user=current_user
    @book_new=Book.new
    @books=Book.all
  end

  def show
    @book=Book.find(params[:id])
    @user=@book.user
    @book_new=Book.new
  end

  def create
    @book_new=Book.new(book_params)
    @book_new.user_id=current_user.id
      if @book_new.save
        flash[:notice] = "You have create user successfully."
        redirect_to book_path(@book_new.id)
      else
        @books=Book.all
        @user=current_user
        render :index
      end
  end

  def edit
    @book=Book.find(params[:id])
    if @book.user.id == current_user.id
    else
    @user=current_user
    @book_new=Book.new
    @books=Book.all
    render:index
    end
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have update user successfully."
      redirect_to book_path(@book.id)
    else
      render:edit
    end
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body, :user_id)
  end
end

