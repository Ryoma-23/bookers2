class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
      #redirect_to book_path(book)
      render :book_comments
    else #kエラーメッセージ反映されな
      @error_comment = @comment
      @book = Book.find(params[:book_id])
      @user = @book.user
      @book_comment = BookComment.new
      render :error
    end
  end

  def destroy
    BookComment.find(params[:id]).destroy
    @book = Book.find(params[:book_id])
    render :book_comments
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
