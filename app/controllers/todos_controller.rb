class TodosController < ApplicationController
  before_action :set_todo, :only => [:show, :edit, :update, :destroy]

  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      redirect_to todos_url
    else
      render  :action => :new
    end
  end
      
  def show
  end

  def edit
  end

  def update
    if @todo.update_attributes(todo_params)
    redirect_to todo_path(@todo)
    else
    render :action => :edit  
    end
  end

  def destroy
    if @todo.can_destroy?
      @todo.destroy
      # 跳出警告訊息，告知成功刪除
      flash[:alert] = 'List was successfully deleted !!'
      # 重新發出 request，導往列表頁。對瀏覽器來說會重整頁面
      redirect_to todos_path
    else
      # 跳出警告訊息，告知過期
      flash[:alert] = 'List is overdue, can not be deleted !!'
      # 重新發出 request，導往列表頁。對瀏覽器來說會重整頁面
      redirect_to todos_path
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:name, :due_date, :note)
  end
end