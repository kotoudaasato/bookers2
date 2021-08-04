class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = BookComment.new(book_params)
    comment.user_id = current_user.id
    comment.book_id = book.id
    if comment.save
      redirect_to book_path(book)
    else
      @book=Book.find(params[:book_id])
      @user=@book.user
      @book_new=Book.new
      @book_comment = BookComment.new
      render :'books/show'
    end

  end

  def destroy
    book_comment=BookComment.find_by(id: params[:id], book_id: params[:book_id])
    book_comment.destroy
    redirect_back(fallback_location: root_path)
  end

   private

  def book_params
    params.require(:book_comment).permit(:comment)
  end
end
