class TodosController < ApplicationController
    def index
        @todos = Todo.all
    end

    def show
        @todo = Todo.find(params[:id])
    end

    def new
        @todo = Todo.new
    end

    def create
        @todo = Todo.new(todo_params)

        if @todo.save
            respond_to do |format|
                format.turbo_stream
                format.html {redirect_to @todo}
            end 
        else
            respond_to do |format|
                format.turbo_stream {render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@todo)}_form", partial: "form", locals: {todo: @todo})}
                format.html {render :new, status: :unprocessable_entity}
            end
        end
    end

    def edit
        @todo = Todo.find(params[:id])
    end

    def update 
        @todo = Todo.find(params[:id])

        respond_to do |format|
            if @todo.update(todo_params)
                format.turbo_stream
                format.html {redirect_to @todo}
            else
                format.html {render :new, status: :unprocessable_entity}
            end
        end

    end

    def destroy
        @todo = Todo.find(params[:id])
        @todo.destroy
    
        redirect_to root_path, status: :see_other
      end

    private
        def todo_params
            params.require(:todo).permit(:task, :is_done)
        end
end
