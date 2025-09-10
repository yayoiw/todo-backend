class TodosController < ApplicationController
  before_action :set_todo, only: [ :update, :destroy ]
  def index
    todos = Todo.all
    render json: todos
  end

  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo, status: :created
    else
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def todo_params
      params.expect(todo: [ :title, :completed ])
    end
end
