class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :block_nonmembers, only: [:show, :edit, :update, :destroy]

  before_action :authenticate

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks
    @memberships = @project.memberships
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)


    # Note from me JQ regarding the following code: the "do" is a RUBY block,
    # and the "|format|" could be anything. It's just a variable to use inside that block.

    respond_to do |format|
      if @project.save

        @project.memberships.create(role: "Owner", user_id: current_user.id)

        format.html { redirect_to project_tasks_path(@project), notice: "Project was successfully created."}
        # format.html { redirect_to @project, :flash => { :success => "Project was successfully created." } }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json


  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to Project.find(params[:id]), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json


    def destroy
      @project = Project.find(params[:id])
      @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private

  def block_nonmembers
    @project = Project.find(params[:id])
    if @project.users.exists?(id: current_user.id)
    else
      redirect_to projects_path, alert: "You do not have access to that project."
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name)
    end
end
