class MembershipsController < ApplicationController

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
    @project = Project.find(1)

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
    @membership.destroy
    redirect_to project_memberships_path(@project), notice: "#{@user.full_name} was successfully removed."
  end


  private

    def membership_params
      params.require(:membership).permit(:user_id, :project_id, :role)
    end

end