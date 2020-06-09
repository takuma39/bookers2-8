class BookCommentsController < ApplicationController
  before_action :authenticate_user!

def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
       flash[:success] = "Comment was successfully created."
    else
      @comment = BookComment.where(book_id: @book.id) # render用
    end
end

def destroy
    @comment = BookComment.find(params[:id])
    if @comment.user != current_user
       redirect_to request.referer
    end
    @comment.destroy
end



private
def book_comment_params
    params.require(:book_comment).permit(:comment)
end

end
