class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate

  # GET /tasks
  # GET /tasks.json
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @project = Project.find(params[:project_id])
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @project = Project.find(params[:project_id])
  end

  # GET /tasks/1/edit
  def edit
    @project = Project.find(params[:project_id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    if @task.save
    flash[:success] = "Task was successfully added to project."
    redirect_to @project
  else
    render :new
  end

  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json


  def update
    @project = Project.find(params[:id])
      if @project.tasks.update_attributes(task_params)
        flash[:success] = "You have successfully updated task details."
        redirect_to project_path(@project)
      else
        flash[:danger] = "Course details were not updated."
      render 'courses/edit'
      end
    end

  # DELETE /tasks/1
  # DELETE /tasks/1.json


    def destroy
      @project = Project.find(params[:id])
      @task.destroy
      redirect_to @project, notice: 'You have successfully deleted a task from this project.'

    end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :due_date, :cbox, :project_id)
    end

end
