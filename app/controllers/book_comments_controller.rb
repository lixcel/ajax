class BookCommentsController < ApplicationController

  def create
    @books = BookComment.all
    book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = book.id
    @comment.save
  end

  def destroy
    @books = BookComment.all

    BookComment.find(params[:id]).destroy
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
