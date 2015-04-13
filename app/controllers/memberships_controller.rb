class MembershipsController < ApplicationController

  def index
    @memberships = Membership.all
    @membership = Membership.new
    @project = Project.find(params[:project_id])
  end

  def create
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.new(params.require(:membership).permit(:user_id,
    :project_id, :role))
    if @membership.save
    @user = @membership.user
    redirect_to project_memberships_path(@project), notice: "#{@user.full_name} was successfully added."
  else
    render :new
  end
  end

  def update
    @project = Project.find(params[:project_id])
      if @membership.update_attributes(membership_params)
        redirect_to project_memberships_path(@project), notice: "You have successfully updated membership details."
      else
        render :edit
      end
    end

  def destroy
    @project = Project.find(params[:project_id])
    @membership.destroy
    redirect_to @project, notice: 'You have successfully deleted a membership from this project.'
  end


end
