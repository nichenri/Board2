class MyThreadsController < ApplicationController

  before_action :set_my_thread, only: [:show, :edit, :update, :destroy] 

  def index
    @my_threads = MyThread.all
  end

  def show 
  end

  def new
    @my_thread = MyThread.new
  end

  def create
    @my_thread = current_user.my_threads.new(my_thread_params)
    if @my_thread.save 
      redirect_to my_threads_path
    else 
      render 'new'
    end
  end

  def edit
  end

  def update
    if @my_thread.update(my_thread_params) 
      redirect_to my_threads_path
    else 
      render 'edit'
    end
  end

  def destroy
    @my_thread.destroy
    redirect_to my_threads_path
  end

  private

    def my_thread_params
      params.require(:my_thread).permit(:title)
    end

    def set_my_thread
      @my_thread = MyThread.find(params[:id])
    end

end
