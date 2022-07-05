class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, except: [:create]
  
  def create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    redirect_to @todo_list, notice: "Task added!"
  end
  
  def destroy
    if @todo_item.destroy
      redirect_to @todo_list, notice: "Task deleted!"
    else
      redirect_to @todo_list, notice: "Unable to delete the task!"
    end 
  end
   
  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: "Task completed!"
  end
  
  def recreate
    @todo_item.update_attribute(:completed_at, nil)
    redirect_to @todo_list, notice: "Task recreated!"
  end
   
  private
  
  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end
  
  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
   end
  
  def todo_item_params
    params[:todo_item].permit(:content);
  end
end
