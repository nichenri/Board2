class CommentsController < ApplicationController

  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @my_thread = MyThread.find(params[:my_thread_id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save 
      redirect_to my_thread_path(@my_thread.id)
    else 
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params) 
      redirect_to my_thread_path(@comment.my_thread_id)
    else 
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to my_thread_path(@comment.my_thread_id)
  end

  private

    def my_thread_params
      params.require(:my_thread).permit(:title)
    end

    def comment_params
      params.require(:comment).permit(:text).merge(my_thread_id: @my_thread.id)
    end

    def set_comment
      @comment = @my_thread.comment.find(params[:id])
    end

end
