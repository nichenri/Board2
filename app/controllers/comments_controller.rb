class CommentsController < ApplicationController

  before_action :set_my_thread
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @my_thread.comments.new(comment_params)
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
      params.require(:comment).permit(:text).merge(user_id: current_user.id)
    end

    def set_my_thread
      @my_thread = MyThread.find(params[:my_thread_id])
    end

    def set_comment
      @comment = @my_thread.comments.find(params[:id])
    end

end
