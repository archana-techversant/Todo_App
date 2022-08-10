class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy change_status ]

  # GET /tasks or /tasks.json
  def index
     @tasks = Task.where(status: params[:status].presence || 'incomplete')
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.turbo_stream { render(turbo_stream: turbo_stream.prepend(:tasks, @task)) }
        format.html { redirect_to tasks_url, notice: "Todo task was successfully created." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace( "#{helpers.dom_id(@task)}_form", partial: "form", locals: { task: @task } )}
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: "Todo-Item was successfully updated." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@task)}_form", partial: "form", locals: { task: @task }) }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
     format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@task)}_container") }
     format.html { redirect_to tasks_url, notice: "Task was successfully destroyed."}
    end
  end
  def change_status
    @task.update(status: task_params[:status])
    respond_to do |format|
      format.turbo_stream {render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@task)}_container")}
      format.html { redirect_to tasks_path, notice: "Updated task status." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :status)
    end
end
