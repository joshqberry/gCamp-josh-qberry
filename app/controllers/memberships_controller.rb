class MembershipsController < ApplicationController
  before_action :block_nonmember
  before_action :block_nonowner, only: [:create, :update]
  before_action :protect_last_owner, only: [:update]

  before_action :authenticate

  def index
    @project = Project.find(params[:project_id])
    @membership = Membership.new

  end

  def create
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.new(params.require(:membership).permit(:user_id,
    :project_id, :role))
    if @membership.save
    @user = @membership.user
    redirect_to project_memberships_path(@project), notice: "#{@user.full_name} was successfully added."
  else
    @project = Project.find(params[:project_id])

    # So the line above is there to prevent the memberships index page from not rendering (apparently,
    # currently, when you save an invalid record, that record persists for a second. Because it does,
    # and because no project is assigned to it, the page is unable to render working links for
    # membership.user and project.memberships). I'm sure there's a better fix, but beats me.

     render :index
  end
  end

  def update
    @project = Project.find(params[:project_id])
    @membership = Membership.find(params[:id])
      if @membership.update_attributes(membership_params)
        @user = @membership.user
        redirect_to project_memberships_path(@project), notice: "#{@user.full_name} was successfully updated."
      else
        redirect_to project_memberships_path(@project)
      end
    end



  def destroy
    @project = Project.find(params[:project_id])
    @membership = Membership.find(params[:id])
    @user = @membership.user
    if  @project.memberships.exists?(user_id: current_user.id) || (current_user.admin?)
    @membership.destroy
    redirect_to projects_path, notice: "#{@user.full_name} was successfully removed."
  end
end

# The code above was originally @project.memberships.exists?(user_id: current_user.id, role: "Member"),
# but I suppose that wasn't strictly blocking a member who is logged in from deleting
# other members (even though a user who is not an owner can't see any link to access that
# action). Anyway, not worrying about it for now.

  private

    def membership_params
      params.require(:membership).permit(:user_id, :project_id, :role)
    end

    def block_nonmember
      if logged_in?
      @project = Project.find(params[:project_id])
        if @project.memberships.exists?(:user_id => current_user.id) || (current_user.admin?)
        else
        redirect_to projects_path, alert: "You do not have access to that project."
      end
    end
  end

    def block_nonowner
      @project = Project.find(params[:project_id])
      if @project.memberships.exists?(user_id: current_user.id, role: "Owner") || (current_user.admin?)
      else
        redirect_to project_path(@project), alert: "You do not have access."
      end
    end

  def protect_last_owner
    @membership = Membership.find(params[:id])
    if (@project.memberships.where(role: "Owner").count == 1) && (@membership.user_id == current_user.id)
      redirect_to project_memberships_path(@project), alert: "Projects must have at least one owner."
    elsif (current_user.admin?) && (@project.memberships.where(role: "Owner").count == 1) && (@membership.role == "Owner")
      redirect_to project_memberships_path(@project), alert: "Projects must have at least one owner."

  end
end


end
