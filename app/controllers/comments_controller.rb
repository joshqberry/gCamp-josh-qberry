class CommentsController < ApplicationController

  before_action :authenticate

  def index
    @task = Task.find(params[:task_id])
    @comment = Comment.new
  end

  def create
    @task = Task.find(params[:task_id])
    @project = @task.project
    @comment = @task.comments.new(params.require(:comment).permit(:user_id,
    :task_id, :body))
    @comment.user_id = current_user.id
    if @comment.save

# Huh, so why could I set membership.user after the save in my memberships controller? Or was
# that just not doing anything anyway?

    redirect_to project_task_path(@project, @task), notice: "Comment was successfully added."
  else
     redirect_to project_task_path(@project, @task)
  end
  end



  def update
    @task = Task.find(params[:task_id])
    @comment = Comment.find(params[:id])
      if @comment.update_attributes(comment_params)
        @user = @comment.user
        redirect_to project_task_path(@project, @task), notice: "Comment was successfully updated."
      else
        render "/projects"
      end
    end



  def destroy
    @task = Task.find(params[:task_id])
    @comment = Comment.find(params[:id])
    @user = @comment.user
    @task.destroy
    redirect_to project_task_path(@project, @task), notice: "Comment was successfully deleted."
  end



  private

    def comment_params
      params.require(:comment).permit(:user_id, :task_id, :body)
    end
end
