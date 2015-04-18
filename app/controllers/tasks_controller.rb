class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate
  before_action :block_nonmember


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
    @task = @project.tasks.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all
    @user = current_user
  end

  # Note that you had to define @comment here since you're creating comments on this page.

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
    @user = current_user
    @task = @project.tasks.new(task_params)
    if @task.save
    redirect_to @project, notice: "Task was successfully added to project."
  else
    render :new
  end

  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json


  def update
    @project = Project.find(params[:project_id])

    # Note that the defining of a project variable above is NOT required for the updating of a task;
    # it's so that the redirect "knows" where to go.
    # Then again, that may not be necessary at all, since the task belongs to a project anyway.
    # Not gonna look at that now...

      if @task.update_attributes(task_params)
        redirect_to project_path(@project), notice: "You have successfully updated task details."
      else
        render :edit
      end
    end

  # DELETE /tasks/1
  # DELETE /tasks/1.json


    def destroy
      @project = Project.find(params[:project_id])
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

    def block_nonmember
      if logged_in?
        @project = Project.find(params[:project_id])
      if @project.users.exists?(id: current_user.id) || (current_user.admin?)


        else
        redirect_to projects_path, alert: "You do not have access to that project."
      end
    end
  end

end
